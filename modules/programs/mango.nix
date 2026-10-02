{ pkgs }:

let
  mangoConfig = pkgs.writeText "mango.conf" ''
    # ==========================================
    # Gaps
    # ==========================================

    gappih=3
    gappiv=0
    gappoh=3
    gappov=8

    # ==========================================
    # Borders
    # ==========================================

    borderpx=2
    border_radius=6
    no_border_when_single=1
    no_radius_when_single=0

    # ==========================================
    # Opacity
    # ==========================================

    focused_opacity=1.0
    unfocused_opacity=1.0

    # ==========================================
    # Blur
    # ==========================================

    blur=0
    blur_layer=0
    blur_optimized=1

    # ==========================================
    # Shadows
    # ==========================================

    shadows=0
    layer_shadows=0

    # ==========================================
    # Animations
    # ==========================================

    animations=0
    layer_animations=0

    # ==========================================
    # Bind
    # ==========================================

    bind=SUPER,Return,spawn,alacritty
    bind=SUPER,t,spawn,qs ipc call applauncher toggle
    bind=SUPER,b,spawn,qs ipc call network toggle

    bind=SUPER+SHIFT,p,spawn,qs ipc call powermenu toggle

    # Window Management
    bind=SUPER,q,killclient
    bind=SUPER,s,togglefloating
    bind=SUPER,f,togglefullscreen
    bind=SUPER+SHIFT,r,reload_config
    bind=SUPER+SHIFT,M,quit

    # Focus Navigation
    bind=SUPER,Left,focusdir,left
    bind=SUPER,Down,focusdir,down
    bind=SUPER,Up,focusdir,up
    bind=SUPER,Right,focusdir,right
    bind=SUPER,h,focusdir,left
    bind=SUPER,j,focusdir,down
    bind=SUPER,k,focusdir,up
    bind=SUPER,l,focusdir,right
    bind=SUPER,Tab,focusstack,next
    bind=ALT,Tab,view,-1
    bind=SUPER+SHIFT,Tab,focusstack,prev

    # Window Exchange
    bind=SUPER+SHIFT,Left,exchange_client,left
    bind=SUPER+SHIFT,Down,exchange_client,down
    bind=SUPER+SHIFT,Up,exchange_client,up
    bind=SUPER+SHIFT,Right,exchange_client,right
    bind=SUPER+SHIFT,h,exchange_client,left
    bind=SUPER+SHIFT,j,exchange_client,down
    bind=SUPER+SHIFT,k,exchange_client,up
    bind=SUPER+SHIFT,l,exchange_client,right

    # Window Resize
    bind=SUPER+CTRL,Left,resizewin,-20,0
    bind=SUPER+CTRL,Right,resizewin,20,0
    bind=SUPER+CTRL,Up,resizewin,0,-20
    bind=SUPER+CTRL,Down,resizewin,0,20
    bind=SUPER+CTRL,h,resizewin,-20,0
    bind=SUPER+CTRL,l,resizewin,20,0
    bind=SUPER+CTRL,k,resizewin,0,-20
    bind=SUPER+CTRL,j,resizewin,0,20

    # Tags / Workspaces
    bind=SUPER,1,view,1
    bind=SUPER,2,view,2
    bind=SUPER,3,view,3
    bind=SUPER,4,view,4
    bind=SUPER,5,view,5
    bind=SUPER,6,view,6
    bind=SUPER,7,view,7
    bind=SUPER,8,view,8
    bind=SUPER,9,view,9

    bind=SUPER+SHIFT,1,tag,1
    bind=SUPER+SHIFT,2,tag,2
    bind=SUPER+SHIFT,3,tag,3
    bind=SUPER+SHIFT,4,tag,4
    bind=SUPER+SHIFT,5,tag,5
    bind=SUPER+SHIFT,6,tag,6
    bind=SUPER+SHIFT,7,tag,7
    bind=SUPER+SHIFT,8,tag,8
    bind=SUPER+SHIFT,9,tag,9

    # Layouts
    bind=SUPER,space,switch_layout
    bind=SUPER+SHIFT,t,setlayout,dwindle
    bind=SUPER,a,setlayout,scroller
    bind=SUPER,m,setlayout,monocle
    bind=SUPER,o,toggleoverview

    bind=SUPER,g,togglegaps
    bind=SUPER+SHIFT,g,toggleglobal
    bind=SUPER,bracketleft,setmfact,-0.05
    bind=SUPER,bracketright,setmfact,+0.05
    bind=SUPER,r,switch_proportion_preset

    # Screenshots & Media
    bind=SUPER+SHIFT,s,spawn_shell, ~/.config/scripts/screenshot

    bind=NONE,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    bind=NONE,XF86AudioLowerVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-
    bind=NONE,XF86AudioRaiseVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+
    bind=NONE,XF86MonBrightnessUp,spawn,brightnessctl set +5%
    bind=NONE,XF86MonBrightnessDown,spawn,brightnessctl set 5%-

    # ==========================================
    # Gestures
    # ==========================================

    gesturebind=none,left,3,viewtoleft_have_client
    gesturebind=none,right,3,viewtoright_have_client
    gesturebind=none,up,3,toggleoverview
    gesturebind=none,down,3,toggleoverview

    # ==========================================
    # Mouse
    # ==========================================

    mousebind=SUPER,btn_left,moveresize,curmove
    mousebind=SUPER,btn_right,moveresize,curresize

    axisbind=SUPER,UP,viewtoleft_have_client
    axisbind=SUPER,DOWN,viewtoright_have_client

    # ==========================================
    # Input
    # ==========================================

    repeat_rate=50
    repeat_delay=300

    disable_trackpad=0
    tap_to_click=1
    tap_and_drag=1
    drag_lock=0
    trackpad_natural_scrolling=0

    cursor_theme=Bibata-Modern-Ice
    cursor_size=24
    cursor_hide_timeout=0

    allow_tearing=1

    # ==========================================
    # Languages
    # ==========================================

    xkb_rules_layout=us,us
    xkb_rules_variant=altgr-intl,colemak_dh
    xkb_rules_options=grp:alt_shift_toggle

    # ==========================================
    # Misc / Focus
    # ==========================================

    axis_bind_apply_timeout=100
    focus_on_activate=1
    idleinhibit_ignore_visible=0
    sloppyfocus=1
    warpcursor=1

    focus_cross_monitor=0
    focus_cross_tag=0

    enable_floating_snap=1
    snap_distance=30
    drag_tile_to_tile=1

    xwayland_persistence=1

    # ==========================================
    # Layout
    # ==========================================

    new_is_master=0
    default_mfact=0.55
    default_nmaster=1
    smartgaps=0

    circle_layout=tile,scroller,grid,deck,monocle,center_tile,vertical_tile,vertical_scroller,vertical_grid,vertical_deck,right_tile,tgmix,dwindle,canvas

    # ==========================================
    # Scroller
    # ==========================================

    scroller_structs=20
    scroller_default_proportion=1.0
    scroller_focus_center=1
    scroller_prefer_center=1
    edge_scroller_pointer_focus=1
    scroller_default_proportion_single=1.0
    scroller_proportion_preset=0.5,1.0

    # ==========================================
    # Overview
    # ==========================================

    enable_hotarea=0
    overviewgappi=5
    overviewgappo=30

    # ==========================================
    # Monitor
    # ==========================================

    monitorrule=name:^eDP-1$,width:1920,height:1080,refresh:75,x:0,y:0,scale:1.0

    # ==========================================
    # Tag Rules
    # ==========================================

    tagrule=id:1,layout_name:monocle
    tagrule=id:2,layout_name:scroller
    tagrule=id:3,layout_name:tile
    tagrule=id:4,layout_name:scroller
    tagrule=id:5,layout_name:scroller
    tagrule=id:6,layout_name:monocle

    # ==========================================
    # Window Rules
    # ==========================================

    windowrule=appid:thunar,focused_opacity:0.80
    windowrule=appid:thunar,unfocused_opacity:0.80

    # Simple Floating Tools
    windowrule=isfloating:1,appid:org.pulseaudio.pavucontrol
    windowrule=isfloating:1,appid:org.quickshell,title:^Network$

    # Native GTK & XDG Desktop Portals / File Selection Dialogs
    windowrule=isfloating:1,appid:xdg-desktop-portal-gtk
    windowrule=isfloating:1,width:816,height:537,appid:dialog
    windowrule=isfloating:1,title:Open File
    windowrule=isfloating:1,title:Select a File
    windowrule=isfloating:1,title:Choose wallpaper
    windowrule=isfloating:1,title:Save As

    # Other Window Rules
    windowrule=animation_type_open:zoom,animation_type_close:zoom,appid:mpv
  '';

in
pkgs.writeShellApplication {
  name = "mango";

  runtimeInputs = [
    pkgs.mango
  ];

  text = ''
    exec ${pkgs.mango}/bin/mango -c ${mangoConfig} "$@"
  '';
}
