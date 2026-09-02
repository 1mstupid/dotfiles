# Load settings from autoconfig.yml (disabled)
config.load_autoconfig(False)

# Aliases for commands
c.aliases = {'q': 'quit', 'w': 'session-save', 'wq': 'quit --save'}

# YouTube minimal CSS is injected via Greasemonkey script
# See: ~/.local/share/qutebrowser/greasemonkey/youtube-minimal.user.js

# Cookie and session persistence
c.content.autoplay = False
c.content.cookies.accept = 'all'
c.content.cookies.store = True
c.auto_save.session = True
# Disable page/resource cache (keeps cookies and logins)
c.downloads.location.prompt = False
c.downloads.remove_finished = 0
c.content.cache.size = 0
# Chromium flags to disable aggressive caching (fixes stale HTML during dev)
c.qt.args = ['disable-http-cache']

# Cookie settings for devtools
config.set('content.cookies.accept', 'all', 'chrome-devtools://*')
config.set('content.cookies.accept', 'all', 'devtools://*')

# User agent overrides for specific sites
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/{webkit_version} (KHTML, like Gecko) {upstream_browser_key}/{upstream_browser_version} Safari/{webkit_version}', 'https://web.whatsapp.com/')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://accounts.google.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/99 Safari/537.36', 'https://*.slack.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://docs.google.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}; rv:71.0) Gecko/20100101 Firefox/71.0', 'https://drive.google.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.6998.208 Safari/537.36', 'https://*.openai.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.6998.208 Safari/537.36', 'https://chatgpt.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.6998.208 Safari/537.36', 'https://auth0.openai.com/*')
config.set('content.headers.user_agent', 'Mozilla/5.0 ({os_info}) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.6998.208 Safari/537.36', 'https://auth.openai.com/*')

# OpenAI login requires third-party cookies (auth0 cross-domain) and DRM for some features
config.set('content.cookies.accept', 'all', 'https://*.openai.com/*')
config.set('content.cookies.accept', 'all', 'https://auth.openai.com/*')
config.set('content.cookies.accept', 'all', 'https://auth0.openai.com/*')
config.set('content.cookies.accept', 'all', 'https://chatgpt.com/*')
config.set('content.tls.certificate_errors', 'ask-block-thirdparty', 'https://*.openai.com/*')

# Load images in devtools
config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')

# Enable JavaScript for devtools and internal pages
config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')

# Notifications
config.set('content.notifications.enabled', True, 'https://redlib.catsarch.com')
config.set('content.notifications.enabled', True, 'https://www.youtube.com')

# Stay in insert mode until Esc is pressed
c.input.insert_mode.auto_leave = False

# Downloads directory
c.downloads.location.directory = '~/Downloads/'

# Render PDFs in-browser instead of downloading

# Tab bar visibility
c.tabs.show = 'always'

# Start page and default page (blank)
c.url.default_page = 'file:///home/waltz/.config/qutebrowser/index.html'
c.url.start_pages = 'file:///home/waltz/.config/qutebrowser/index.html'

# Search engines (Kagi as default)
c.url.searchengines = {
    'DEFAULT': 'https://duckduckgo.com/?q={}',
    'nyaa': "https://nyaa.si/?f=0&c=0_0&q={}",
}

# =============================================================================
# Colors - Plan 9 (acme-inspired)
# =============================================================================

_p9 = {
    'bg':          '#000000',  # background
    'fg':          '#ffffff',  # foreground
    'grey':        '#000000',  # dark surface tone
    'dim_grey':    '#ffffff',  # secondary text
    'dark_grey':   '#999999',  # subtle dark background
    'panel':       '#000000',  # panel background
    'surface':     '#000000',  # surface background
    'yellow_bg':   '#1f1f1f',  # muted warning bg
    'border':      '#ffffff',  # borders
    'blue':        '#ffffff',  # blue accent
    'link_blue':   '#ffffff',  # link accent
    'bright_blue': '#ffffff',
    'cyan':        '#ffffff',  # cyan accent
    'dim_cyan':    '#ffffff',  # aqua accent
    'cyan_bg':     '#1a1a1a',  # selection background
    'green':       '#ffffff',  # green accent
    'green_bg':    '#1a1a1a',  # dark highlight background
    'red':         '#ffffff',  # red accent
    'red_bg':      '#1a1a1a',  # error/alert background
    'magenta':     '#ffffff',  # purple accent
    'yellow':      '#ffffff',  # yellow accent
}

# Webpage colors - do NOT override; let sites render natively
c.colors.webpage.bg = 'white'
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.preferred_color_scheme = 'auto'

# Ensure no user stylesheets paint external sites
c.content.user_stylesheets = []

# Web fonts
c.fonts.web.family.standard = ''
c.fonts.web.family.serif = ''
c.fonts.web.family.sans_serif = ''
c.fonts.web.family.fixed = ''
c.fonts.web.size.default = 16
c.fonts.web.size.default_fixed = 13
c.fonts.web.size.minimum = 0

# Completion widget (multi-colored menu text)
c.colors.completion.fg = _p9['fg']
c.colors.completion.odd.bg = _p9['bg']
c.colors.completion.even.bg = _p9['surface']
c.colors.completion.category.fg = _p9['green']
c.colors.completion.category.bg = _p9['panel']
c.colors.completion.category.border.top = _p9['cyan']
c.colors.completion.category.border.bottom = _p9['cyan']
c.colors.completion.item.selected.fg = _p9['fg']
c.colors.completion.item.selected.bg = _p9['panel']
c.colors.completion.item.selected.match.fg = _p9['red']
c.colors.completion.match.fg = _p9['green']
c.colors.completion.scrollbar.fg = _p9['dark_grey']
c.colors.completion.scrollbar.bg = _p9['panel']

# Downloads
c.colors.downloads.bar.bg = _p9['panel']
c.colors.downloads.start.bg = _p9['cyan']
c.colors.downloads.start.fg = _p9['bg']
c.colors.downloads.stop.bg = _p9['green']
c.colors.downloads.stop.fg = _p9['bg']
c.colors.downloads.error.bg = _p9['red']
c.colors.downloads.error.fg = _p9['bg']

# Hints
c.colors.hints.fg = _p9['fg']
c.colors.hints.bg = _p9['yellow_bg']
c.colors.hints.match.fg = _p9['red']

# Messages
c.colors.messages.info.bg = _p9['panel']
c.colors.messages.info.fg = _p9['fg']
c.colors.messages.info.border = _p9['cyan']
c.colors.messages.warning.bg = _p9['yellow_bg']
c.colors.messages.warning.fg = _p9['fg']
c.colors.messages.warning.border = _p9['yellow']
c.colors.messages.error.bg = _p9['red_bg']
c.colors.messages.error.fg = _p9['red']
c.colors.messages.error.border = _p9['red']

# Prompts
c.colors.prompts.bg = _p9['panel']
c.colors.prompts.fg = _p9['fg']
c.colors.prompts.border = _p9['cyan']
c.colors.prompts.selected.bg = _p9['cyan_bg']
c.colors.prompts.selected.fg = _p9['fg']

# Statusbar
c.colors.statusbar.normal.bg = _p9['panel']
c.colors.statusbar.normal.fg = _p9['fg']
c.colors.statusbar.insert.fg = _p9['fg']
c.colors.statusbar.insert.bg = _p9['green_bg']
c.colors.statusbar.passthrough.bg = _p9['cyan_bg']
c.colors.statusbar.passthrough.fg = _p9['fg']
c.colors.statusbar.command.bg = _p9['panel']
c.colors.statusbar.command.fg = _p9['fg']
c.colors.statusbar.caret.bg = _p9['magenta']
c.colors.statusbar.caret.fg = _p9['bg']
c.colors.statusbar.caret.selection.bg = _p9['magenta']
c.colors.statusbar.caret.selection.fg = _p9['bg']
c.colors.statusbar.url.fg = _p9['fg']
c.colors.statusbar.url.success.http.fg = _p9['green']
c.colors.statusbar.url.success.https.fg = _p9['green']
c.colors.statusbar.url.hover.fg = _p9['link_blue']
c.colors.statusbar.url.warn.fg = _p9['yellow']
c.colors.statusbar.url.error.fg = _p9['red']

# Tabs: inactive = grey, active = cyan_bg (same blue highlight as headers)
c.colors.tabs.bar.bg = _p9['panel']
c.colors.tabs.odd.bg = _p9['grey']
c.colors.tabs.odd.fg = _p9['dark_grey']
c.colors.tabs.even.bg = _p9['grey']
c.colors.tabs.even.fg = _p9['dark_grey']
c.colors.tabs.selected.odd.bg = _p9['panel']
c.colors.tabs.selected.odd.fg = _p9['fg']
c.colors.tabs.selected.even.bg = _p9['panel']
c.colors.tabs.selected.even.fg = _p9['fg']
c.colors.tabs.pinned.odd.bg = _p9['grey']
c.colors.tabs.pinned.odd.fg = _p9['dark_grey']
c.colors.tabs.pinned.even.bg = _p9['grey']
c.colors.tabs.pinned.even.fg = _p9['dark_grey']
c.colors.tabs.pinned.selected.odd.bg = _p9['panel']
c.colors.tabs.pinned.selected.odd.fg = _p9['fg']
c.colors.tabs.pinned.selected.even.bg = _p9['panel']
c.colors.tabs.pinned.selected.even.fg = _p9['fg']
c.colors.tabs.indicator.start = _p9['cyan']
c.colors.tabs.indicator.stop = _p9['green']
c.colors.tabs.indicator.error = _p9['red']

# =============================================================================
# Aliases
# =============================================================================

c.aliases.update({
    'readability': 'spawn --userscript readability-js',
    'mpv': 'spawn --userscript view_in_mpv',
    'feeds': 'spawn --userscript openfeeds',
    'pass': 'spawn --userscript qute-pass',
    'json': 'spawn --userscript format_json',
    'rss': 'spawn --userscript rss',
    'zotero': 'spawn --userscript qute-zotero',
})

# Node.js module path for readability-js
c.qt.environ = {"NODE_PATH": "/usr/lib/node_modules"}

# =============================================================================
# Keybindings
# =============================================================================

# dmenu integration (commented out for consideration)
# config.bind('o', 'spawn --userscript qutedmenu')
# config.bind('O', 'spawn --userscript qutedmenu --tab')

# Normal mode bindings
# Translate page
config.bind(',gt', ':open -t translate.google.com/translate?sl=auto&tl=en-US&u={url}')
config.unbind('d')
config.bind('F', 'hint --rapid links tab-bg')
config.bind('c', 'tab-close')
config.bind('h', 'back')
config.bind('l', 'forward')
config.bind('f', 'hint')
config.bind('M', 'hint links spawn mpv {hint-url}')
config.bind('Z', 'hint links spawn st -e youtube-dl {hint-url}')
config.bind('t', 'set-cmd-text -s :open -t')
config.bind('xb', 'config-cycle statusbar.show always never')
config.bind('xt', 'config-cycle tabs.show always never')
config.bind('xx', 'config-cycle statusbar.show always never;; config-cycle tabs.show always never')

# Userscript bindings

config.bind(',sa', 'spawn --userscript select-scroll-to-anchor')
config.bind(',of', 'spawn --userscript open-file')
config.bind(',fd', 'hint links userscript open-domain')
config.bind(',r', 'spawn --userscript readability-js')
config.bind(',m', 'spawn --userscript view_in_mpv')
config.bind(',hm', 'hint links userscript view_in_mpv')
config.bind(",t", "hint links userscript motrix")
config.bind(',f', 'spawn --userscript openfeeds')
config.bind(',p', 'spawn --userscript qute-pass')
config.bind(',j', 'spawn --userscript format_json')
config.bind(',z', 'spawn --userscript qute-zotero')
config.bind(',Z', 'hint links spawn --userscript qute-zotero')

# Dark mode toggle
config.bind(',dm', 'config-cycle colors.webpage.darkmode.enabled true false')
