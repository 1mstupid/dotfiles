// ==UserScript==
// @name YouTube Black & Gold Theme
// @match https://www.youtube.com/*
// @run-at document-idle
// ==/UserScript==

(function() {
    const style = document.createElement("style");
    style.id = "youtube-custom-theme";

    style.textContent = `
:root {
    --gb-bg: #000000;
    --gb-bg1: #000000;
    --gb-bg2: #000000;
    --gb-fg: #ffffff;
    --gb-fg2: #ffffff;
    --gb-orange: #ffffff;
    --gb-green: #ffffff;
}

/* Main backgrounds */
html,
body,
ytd-app,
ytd-watch-flexy,
ytd-page-manager,
#page-manager,
#content,
#primary {
    background: var(--gb-bg) !important;
}

/* Cards / panels */
ytd-rich-item-renderer,
ytd-video-renderer,
ytd-compact-video-renderer {
    background: var(--gb-bg) !important;
}

/* Text */
yt-formatted-string,
#video-title,
.title,
a {
    color: var(--gb-fg) !important;
}

/* Secondary text */
#metadata-line,
#description,
ytd-video-meta-block {
    color: var(--gb-fg2) !important;
}

/* Search bar */
#search,
ytd-searchbox {
    background: var(--gb-bg1) !important;
    color: var(--gb-fg) !important;
}

/* Buttons */
button,
yt-icon-button {
    color: var(--gb-fg) !important;
}

/* Hover accents */
ytd-rich-item-renderer:hover #video-title {
    color: var(--gb-orange) !important;
}
`;

    document.head.appendChild(style);
})();
