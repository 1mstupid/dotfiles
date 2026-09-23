#pragma once

#include <X11/XF86keysym.h>

/* appearance */
static const unsigned int borderpx = 0; /* border pixel of windows */
static const unsigned int snap = 22;    /* snap pixel */
static const int showbar = 1;           /* 0 means no bar */
static const int topbar = 1;            /* 0 means bottom bar */
static const char *fonts[] = {"GohuFont uni14 Nerd Font:size=11.5"};
static const char dmenufont[] = "GohuFont uni14 Nerd Font:size=11";

#if !XRDB // when xrdb is turned off

static const char col_gray1[] = "#000000";
static const char col_gray2[] = "#c0c0c0";
static const char col_gray3[] = "#e1e1e1";
static const char col_gray4[] = "#f9f4d4";
static const char col_gray[] = "#c0c0c0";
static const char col_sel_bg[] = "#313131";
static const char col_sel_fg[] = "#e1e1e1";
static const char col_red[] = "#fd1b7c";
static const char col_black[] = "#1c1c1c";
static const char col_white[] = "#fffeff";
static const char *colors[][3] = {
    /*               fg         bg         border   */
    [SchemeNorm] = {col_white, col_black, col_gray1},
    [SchemeSel] = {col_white, col_black, col_white},
};

#else // when xrdb is turned on

static char normbgcolor[] = "#222222";
static char normbordercolor[] = "#444444";
static char normfgcolor[] = "#bbbbbb";
static char selfgcolor[] = "#eeeeee";
static char selbordercolor[] = "#ffffff";
static char selbgcolor[] = "#ffffff";
static char *colors[][3] = {
    /*               fg           bg           border   */
    [SchemeNorm] = {normfgcolor, normbgcolor, normbordercolor},
    [SchemeSel] = {selfgcolor, selbgcolor, selbordercolor},
};

#endif

#if GAPS
static const unsigned int gappx = 5;
#endif

#if BAR_HEIGHT
static const int user_bh = 0;
#endif

#if BAR_PADDING
static const int vertpad = 5; /* vertical padding of bar */
static const int sidepad = 5; /* horizontal padding of bar */
#endif

/* tagging */
static const char *tags[] = {"1", "2", "3", "4", "5", "6", "7", "8", "9"};

#if OCCUPIED_TAGS_DECORATION
static const char *occupiedtags[] = {"1", "2", "3", "4", "5",
                                     "6", "7", "8", "9"};
#endif

#if INFINITE_TAGS
#define MOVE_CANVAS_STEP                                                       \
  120 /* Defines how many pixel will be jumped when using movecanvas function  \
       */
#endif

#if MOVE_RESIZE_WITH_KEYBOARD
#define MOVE_WITH_KEYBOARD_STEP                                                \
  50 /* Defines by how many pixels windows will be resized with keyboard */
#define RESIZE_WITH_KEYBOARD_STEP                                              \
  50 /* Defines by how many pixels windows will be resized with keyboard */
#endif

static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title
     */
    /* class      instance    title       tags mask     isfloating   monitor */
    {"Gimp", NULL, NULL, 0, 1, -1},
    {"firefox", NULL, NULL, 1 << 8, 0, -1},
};

static const char *const autostart[] = {
    "flatpak run com.valvesoftware.Steam -silent",
    NULL
};

/* layout(s) */
static const float mfact = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;    /* number of clients in master area */
static const int resizehints =
    1; /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen =
    1; /* 1 will force focus on the fullscreen window */
#if LOCK_MOVE_RESIZE_REFRESH_RATE
static const int refreshrate =
    120; /* refresh rate (per second) for client move/resize, set it to your
            monitor refresh rate or double of that*/
#endif   // LOCK_MOVE_RESIZE_REFRESH_RATE
static const Layout layouts[] = {
    /* symbol     arrange function */
    {"[]=", tile}, /* first entry is default */
    {"><>", NULL}, /* no layout function means floating behavior */
    {"[M]", monocle},
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY, TAG)                                                      \
  {MODKEY, KEY, view, {.ui = 1 << TAG}},                                       \
      {MODKEY | ControlMask, KEY, toggleview, {.ui = 1 << TAG}},               \
      {Mod1Mask, KEY, tag, {.ui = 1 << TAG}},                                  \
      {MODKEY | ControlMask | ShiftMask, KEY, toggletag, {.ui = 1 << TAG}},

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd)                                                             \
  {                                                                            \
    .v = (const char *[]) { "/bin/sh", "-c", cmd, NULL }                       \
  }

/* commands */
static char dmenumon[2] =
    "0"; /* component of dmenucmd, manipulated in spawn() */
#if !XRDB // when xrdb is turned off

static const char *bemenucmd[] = {
    "j4-dmenu-desktop",
    "--dmenu=bemenu --tb \"#1c1c1c\" --tf \"#eeeeee\" --fb \"#1c1c1c\" --ff \"#eeeeee\" --cb \"#1c1c1c\" --hb \"#1c1c1c\" --sb \"#1c1c1c\" --ab \"#1c1c1c\" --nb \"#1c1c1c\" -l 10 -c -M 760",
    NULL
};

/* bemenu */
static const char *flatpakcmd[] = {
    "bemenu-run",
    "--tb", "#1c1c1c",
    "--tf", "#eeeeee",
    "--fb", "#1c1c1c",
    "--ff", "#eeeeee",
    "--cb", "#1c1c1c",
    "--hb", "#1c1c1c",
    "--sb", "#1c1c1c",
    "--ab", "#1c1c1c",
    "--nb", "#1c1c1c",
    "-l", "15",
    "-c",
    "-M", "760",
    NULL
};

#else // when xrdb is on
static const char *bemenucmd[] = {"bemenu-run",    "-fn", dmenufont,   "-nb",
                                 normbgcolor,    "-nf", normfgcolor, "-sb",
                                 selbordercolor, "-sf", selfgcolor,  NULL};
#endif

// Commands
static const char *brightup[] = {"sh", "-c",
                                 "~/.local/bin/brightness_control.sh --inc 5 "
                                 "&& ~/.local/bin/brightness_notify.sh",
                                 NULL};

static const char *brightdown[] = {"sh", "-c",
                                   "~/.local/bin/brightness_control.sh --dec 5"
                                   "&& ~/.local/bin/brightness_notify.sh",
                                   NULL};

static const char *kmonad_toggle[] = {"/home/waltz/.config/vxwm/scripts/kmonad.sh", NULL};

static const char *volup[] = {
    "sh", "-c", "pamixer -i 1 && ~/.config/vxwm/scripts/volume_notify", NULL};

static const char *voldown[] = {
    "sh", "-c", "pamixer -d 1 && ~/.config/vxwm/scripts/volume_notify", NULL};

static const char *volmute[] = {
    "sh", "-c", "pamixer -t && ~/.config/vxwm/scripts/volume_notify", NULL};

static const char *termcmd[] = {"st", "-e", "bash", NULL};

// static const char *browserA[] = {"firefox", NULL};

static const char *web[] = {"flatpak","run","net.waterfox.waterfox", NULL};

static const Key keys[] = {
    /* modifier                     key        function        argument */
    {MODKEY, XK_t, spawn, {.v = bemenucmd}},
    {MODKEY | ControlMask, XK_t, spawn, {.v = flatpakcmd}},
    {MODKEY, XK_v, spawn, SHCMD("~/.config/vxwm/scripts/txtcliphist sel")},
    {MODKEY | ShiftMask, XK_w, spawn,
     SHCMD("~/.config/vxwm/scripts/wallpaper.sh")},
    {MODKEY, XK_r, spawn, {.v = termcmd}},
    {MODKEY | ShiftMask, XK_r, spawn, SHCMD("~/.config/vxwm/scripts/record")},
    {MODKEY, XK_p, spawn,
     SHCMD("maim -s ~/Pictures/Screenshots/$(date +%s).png | xclip -selection "
           "clipboard -t image/png")},
    {MODKEY | ControlMask, XK_p, spawn, SHCMD("xcolor | xclip -sel clip")},
    {MODKEY, XK_w, spawn, {.v = web}},
    {ControlMask | ShiftMask, XK_c, spawn, SHCMD("xclip -o -selection primary | ~/.config/vxwm/scripts/txtcliphist out")},
    // {MODKEY | ControlMask,XK_w, spawn, {.v = browserB}},
    // {MODKEY, XK_e, spawn, SHCMD("st -e yazi")},
    {MODKEY | ShiftMask, XK_g, spawn, {.v = kmonad_toggle}},
    {0, XF86XK_AudioRaiseVolume, spawn, {.v = volup}},
    {0, XF86XK_AudioLowerVolume, spawn, {.v = voldown}},
    {ShiftMask, XF86XK_AudioRaiseVolume, spawn, {.v = brightup}},
    {ShiftMask, XF86XK_AudioLowerVolume, spawn, {.v = brightdown}},
    {0, XF86XK_AudioMute, spawn, {.v = volmute}},
    {MODKEY, XK_b, togglebar, {0}},
    {MODKEY, XK_j, focusstack, {.i = +1}},
    {MODKEY, XK_k, focusstack, {.i = -1}},
    {MODKEY, XK_i, incnmaster, {.i = +1}},
    {MODKEY, XK_d, incnmaster, {.i = -1}},
    {MODKEY, XK_h, setmfact, {.f = -0.05}},
    {MODKEY, XK_l, setmfact, {.f = +0.05}},
    {MODKEY, XK_Return, zoom, {0}},
    {MODKEY, XK_Tab, view, {0}},
    {MODKEY, XK_q, killclient, {0}},
    {MODKEY | ShiftMask, XK_t, setlayout, {.v = &layouts[0]}},
    {MODKEY | ShiftMask, XK_o, setlayout, {.v = &layouts[1]}},
    {MODKEY | ShiftMask, XK_f, setlayout, {.v = &layouts[2]}},
    {MODKEY | ShiftMask, XK_m, setlayout, {.v = &layouts[3]}},
    {MODKEY, XK_space, setlayout, {0}},
    {MODKEY | ShiftMask, XK_space, togglefloating, {0}},
    {MODKEY, XK_0, view, {.ui = ~0}},
    {MODKEY | ShiftMask, XK_0, tag, {.ui = ~0}},
    {MODKEY, XK_comma, focusmon, {.i = -1}},
    {MODKEY, XK_period, focusmon, {.i = +1}},
    {MODKEY | ShiftMask, XK_comma, tagmon, {.i = -1}},
    {MODKEY | ShiftMask, XK_period, tagmon, {.i = +1}},
    TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2) TAGKEYS(XK_4, 3)
        TAGKEYS(XK_5, 4) TAGKEYS(XK_6, 5) TAGKEYS(XK_7, 6) TAGKEYS(XK_8, 7)
            TAGKEYS(XK_9, 8){MODKEY | ShiftMask, XK_q, quit, {0}},
#if XRDB
    {MODKEY, XK_F5, xrdb, {.v = NULL}},
#endif
#if FULLSCREEN
    {MODKEY | ShiftMask, XK_f, togglefullscr, {0}},
#endif
#if ENHANCED_TOGGLE_FLOATING
    {MODKEY,
     XK_x,
     enhancedtogglefloating,
     {0}}, // enhanced toggle floating bind.
#endif
#if GAPS
    {MODKEY, XK_minus, setgaps, {.i = -1}},
    {MODKEY, XK_equal, setgaps, {.i = +1}},
    {MODKEY | ShiftMask, XK_equal, setgaps, {.i = 0}},
#endif
#if MOVE_RESIZE_WITH_KEYBOARD
    {MODKEY,
     XK_Down,
     moveresize,
     {.v = (int[]){0, MOVE_WITH_KEYBOARD_STEP, 0, 0}}},
    {MODKEY,
     XK_Up,
     moveresize,
     {.v = (int[]){0, -MOVE_WITH_KEYBOARD_STEP, 0, 0}}},
    {MODKEY,
     XK_Right,
     moveresize,
     {.v = (int[]){MOVE_WITH_KEYBOARD_STEP, 0, 0, 0}}},
    {MODKEY,
     XK_Left,
     moveresize,
     {.v = (int[]){-MOVE_WITH_KEYBOARD_STEP, 0, 0, 0}}},
    {MODKEY | ControlMask,
     XK_Down,
     moveresize,
     {.v = (int[]){0, 0, 0, RESIZE_WITH_KEYBOARD_STEP}}},
    {MODKEY | ControlMask,
     XK_Up,
     moveresize,
     {.v = (int[]){0, 0, 0, -RESIZE_WITH_KEYBOARD_STEP}}},
    {MODKEY | ControlMask,
     XK_Right,
     moveresize,
     {.v = (int[]){0, 0, RESIZE_WITH_KEYBOARD_STEP, 0}}},
    {MODKEY | ControlMask,
     XK_Left,
     moveresize,
     {.v = (int[]){0, 0, -RESIZE_WITH_KEYBOARD_STEP, 0}}},
#endif
#if INFINITE_TAGS
    {MODKEY | ShiftMask,
     XK_Left,
     movecanvas,
     {.i = 0}}, // Move your position to left
    {MODKEY | ShiftMask,
     XK_Right,
     movecanvas,
     {.i = 1}}, // Move your position to right
    {MODKEY | ShiftMask, XK_Up, movecanvas, {.i = 2}}, // Move your position up
    {MODKEY | ShiftMask,
     XK_Down,
     movecanvas,
     {.i = 3}}, // Move your position down
    {MODKEY, XK_m, homecanvas, {0}},
    {MODKEY | ShiftMask, XK_d, centerwindow, {0}},
#endif
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle,
 * ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
/* click                event mask      button          function        argument
 */
#if INFINITE_TAGS
    {ClkRootWin, MODKEY | ShiftMask, Button1, manuallymovecanvas, {0}},
    {ClkClientWin, MODKEY | ShiftMask, Button1, manuallymovecanvas, {0}},
#endif
    {ClkLtSymbol, 0, Button1, setlayout, {0}},
    {ClkLtSymbol, 0, Button3, setlayout, {.v = &layouts[2]}},
    {ClkWinTitle, 0, Button2, zoom, {0}},
    {ClkStatusText, 0, Button2, spawn, {.v = termcmd}},
    {ClkClientWin, MODKEY, Button1, movemouse, {0}},
    {ClkClientWin, MODKEY, Button2, togglefloating, {0}},
    {ClkClientWin, MODKEY, Button3, resizemouse, {0}},
    {ClkTagBar, 0, Button1, view, {0}},
    {ClkTagBar, 0, Button3, toggleview, {0}},
    {ClkTagBar, MODKEY, Button1, tag, {0}},
    {ClkTagBar, MODKEY, Button3, toggletag, {0}},
};
