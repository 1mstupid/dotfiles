// ==UserScript==
// @name         Universal Ad Blocker Pro
// @namespace    https://github.com/yourusername/universal-ad-blocker
// @version      6.0.0
// @description  Comprehensive ad blocking across YouTube, Facebook, Twitter/X, Instagram, Reddit, news sites, and more.
// @author       Gorstak
// @license      MIT
// @match        *://*.youtube.com/*
// @match        *://*.facebook.com/*
// @match        *://*.twitter.com/*
// @match        *://*.x.com/*
// @match        *://*.instagram.com/*
// @match        *://*.reddit.com/*
// @match        *://*.twitch.tv/*
// @match        *://*.linkedin.com/*
// @match        *://*.pinterest.com/*
// @match        *://*.tiktok.com/*
// @match        *://*.news.google.com/*
// @match        *://*.cnn.com/*
// @match        *://*.forbes.com/*
// @match        *://*.nytimes.com/*
// @match        *://*.washingtonpost.com/*
// @match        *://*.theguardian.com/*
// @match        *://*.bbc.com/*
// @match        *://*.medium.com/*
// @match        *://*.fandom.com/*
// @match        *://*.wikia.com/*
// @grant        none
// @run-at       document-start
// @downloadURL https://update.greasyfork.org/scripts/561518/Universal%20Ad%20Blocker%20Pro.user.js
// @updateURL https://update.greasyfork.org/scripts/561518/Universal%20Ad%20Blocker%20Pro.meta.js
// ==/UserScript==

(() => {
  "use strict";
  console.log("[Universal Ad Blocker] Initializing...");

  const blockedDomains = [
    "doubleclick.net", "googleadservices.com", "googlesyndication.com", "adservice.google.com",
    "amazon-adsystem.com", "taboola.com", "outbrain.com", "criteo.com", "scorecardresearch.com",
    "ads-twitter.com", "static.ads-twitter.com", "advertising.com", "adnxs.com", "pubmatic.com",
    "rubiconproject.com", "adsafeprotected.com", "moatads.com", "advertising.yahoo.com",
    "adtech.de", "adform.net", "serving-sys.com", "google-analytics.com", "googletagmanager.com",
    "facebook.com/tr", "connect.facebook.net", "pixel.facebook.com", "analytics.twitter.com",
    "pixel.reddit.com", "ads.linkedin.com", "analytics.tiktok.com", "hotjar.com", "fullstory.com",
    "segment.io", "segment.com", "mixpanel.com", "amplitude.com"
  ];

  const blockedPatterns = [
    "/api/stats/ads", "/api/stats/atr", "/pagead/", "/ptracking", "/ad?", "/ads?", "/advert",
    "/sponsored", "/promotion", "/tracking", "/analytics", "/collect?", "/beacon", "/pixel",
    "/imp?", "/impression", "/click?", "ad_banner", "ad_frame", "sponsored_content", "promo_banner"
  ];

  // Network interception
  const originalFetch = window.fetch;
  window.fetch = function (...args) {
    const url = typeof args[0] === "string" ? args[0] : (args[0]?.url || "");
    if (blockedDomains.some(d => url.includes(d)) || blockedPatterns.some(p => url.includes(p))) {
      return Promise.reject(new Error("Blocked by Universal Ad Blocker"));
    }
    return originalFetch.apply(this, args);
  };

  const originalOpen = XMLHttpRequest.prototype.open;
  XMLHttpRequest.prototype.open = function (method, url, ...rest) {
    if (typeof url === "string" &&
      (blockedDomains.some(d => url.includes(d)) || blockedPatterns.some(p => url.includes(p)))) {
      return;
    }
    return originalOpen.call(this, method, url, ...rest);
  };

  // =========================
  // YouTube hardened section
  // =========================
  function nukePlayerAdsObject(obj) {
    if (!obj || typeof obj !== "object") return;
    const adKeys = ["adPlacements", "adSlots", "playerAds", "adBreakHeartbeatParams", "ad3Module", "adSafetyReason"];
    for (const key of adKeys) if (key in obj) delete obj[key];
    for (const k of Object.keys(obj)) {
      if (obj[k] && typeof obj[k] === "object") nukePlayerAdsObject(obj[k]);
    }
  }

  const _jsonParse = JSON.parse;
  JSON.parse = function (...args) {
    const out = _jsonParse.apply(this, args);
    try { if (out && typeof out === "object") nukePlayerAdsObject(out); } catch {}
    return out;
  };

  function removeYouTubeAds() {
    document.querySelectorAll(
      ".ytp-ad-skip-button, .ytp-skip-ad-button, .ytp-ad-skip-button-modern, .ytp-skip-ad-button__text"
    ).forEach(btn => btn.click && btn.click());

    [
      ".ytp-ad-module", ".ytp-ad-player-overlay", ".ytp-ad-overlay-container",
      ".video-ads", "#player-ads", "ytd-display-ad-renderer",
      "ytd-promoted-sparkles-web-renderer", "ytd-promoted-video-renderer",
      "ytd-ad-slot-renderer", "ytd-banner-promo-renderer"
    ].forEach(sel => document.querySelectorAll(sel).forEach(el => el.remove()));

    const player = document.querySelector(".html5-video-player");
    const video = document.querySelector("video");
    if (player && player.classList.contains("ad-showing") && video) {
      if (Number.isFinite(video.duration) && video.duration > 0) {
        video.currentTime = Math.max(0, video.duration - 0.1);
      }
      video.muted = true;
      video.playbackRate = 16;
      video.play().catch(() => {});
      player.classList.remove("ad-showing");
    }
  }

  // Other sites
  function removeFacebookAds() {
    document.querySelectorAll('div[role="article"]').forEach(article => {
      if (/sponsored/i.test(article.textContent || "")) article.style.display = "none";
    });
  }

  function removeTwitterAds() {
    document.querySelectorAll('article, [data-testid="placementTracking"]').forEach(el => {
      const t = el.textContent || "";
      if (/promoted|ad ·|advertisement/i.test(t) || el.matches('[data-testid="placementTracking"]')) {
        el.style.display = "none";
      }
    });
  }

  function removeRedditAds() {
    const sels = ['div[data-promoted="true"]', 'a[data-click-id="promoted"]', ".promotedlink", "shreddit-ad-post"];
    sels.forEach(sel => document.querySelectorAll(sel).forEach(el => el.remove()));
  }

  function removeInstagramAds() {
    document.querySelectorAll("article").forEach(a => {
      if (/sponsored/i.test(a.textContent || "")) a.style.display = "none";
    });
  }

  function removeLinkedInAds() {
    document.querySelectorAll(".feed-shared-update-v2, [data-ad-banner-id], [data-is-sponsored='true']").forEach(el => {
      if (/promoted|sponsored/i.test(el.textContent || "")) el.remove();
    });
  }

  function removeTwitchAds() {
    ['[data-a-target="video-ad-label"]', ".video-ad", ".advertisement-banner"]
      .forEach(sel => document.querySelectorAll(sel).forEach(el => el.remove()));
  }

  function removeGenericAds() {
    [
      "ins.adsbygoogle", 'iframe[id*="google_ads"]', 'iframe[id*="aswift"]',
      'div[id*="taboola"]', 'div[id*="outbrain"]', 'div[class*="advert"]',
      ".video-ad-overlay", ".preroll-ad", ".midroll-ad"
    ].forEach(sel => document.querySelectorAll(sel).forEach(el => el.remove()));
  }

  function removeAllAds() {
    const h = location.hostname;
    if (h.includes("youtube.com")) {
      nukePlayerAdsObject(window.ytInitialPlayerResponse);
      nukePlayerAdsObject(window.ytInitialData);
      removeYouTubeAds();
    } else if (h.includes("facebook.com")) {
      removeFacebookAds();
    } else if (h.includes("twitter.com") || h.includes("x.com")) {
      removeTwitterAds();
    } else if (h.includes("reddit.com")) {
      removeRedditAds();
    } else if (h.includes("instagram.com")) {
      removeInstagramAds();
    } else if (h.includes("linkedin.com")) {
      removeLinkedInAds();
    } else if (h.includes("twitch.tv")) {
      removeTwitchAds();
    }
    removeGenericAds();
  }

  removeAllAds();

  const intervalMs = location.hostname.includes("youtube.com") ? 300 : 1000;
  setInterval(removeAllAds, intervalMs);

  const startObserver = () => {
    const obs = new MutationObserver(removeAllAds);
    obs.observe(document.documentElement, { childList: true, subtree: true });
  };

  if (document.documentElement) startObserver();
  else document.addEventListener("DOMContentLoaded", startObserver);

  console.log("[Universal Ad Blocker] Initialized");
})();