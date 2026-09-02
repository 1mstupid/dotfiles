// ==UserScript==
// @name YouTube clean layout
// @match https://www.youtube.com/*
// @run-at document-idle
// ==/UserScript==

(function() {
    const css = `
#columns #secondary {
    display: none !important;
}

#top-level-buttons-computed,
#voice-search-button,
ytd-mini-guide-renderer,
#related,
tp-yt-app-drawer,
.ytd-masthead #buttons,
#guide-button,
[class="style-scope ytd-comments"] {
    display: none !important;
}

#page-manager {
    margin-left: 0 !important;
}

#columns {
    width: 100% !important;
}

ytd-watch-flexy:not([theatre]):not([fullscreen]) .html5-video-container,
ytd-watch-flexy:not([theatre]):not([fullscreen]) video {
    width: 100% !important;
    height: 100% !important;
    left: 0 !important;
}
`;

    let style = document.getElementById("yt-clean-layout-style");

    if (!style) {
        style = document.createElement("style");
        style.id = "yt-clean-layout-style";
        document.head.appendChild(style);
    }

    style.textContent = css;
})();
