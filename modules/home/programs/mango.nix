{ pkgs, ... }:

{
  wayland.windowManager.mango = {
    enable = true;

    settings = {
      # ==========================================
      # Gaps
      # ==========================================

      gappih = 0;
      gappiv = 0;
      gappoh = 0;
      gappov = 8;

      # ==========================================
      # Borders
      # ==========================================

      borderpx = 2;
      border_radius = 0;
      no_border_when_single = 1;
      no_radius_when_single = 0;

      # ==========================================
      # Opacity
      # ==========================================

      focused_opacity = 1.0;
      unfocused_opacity = 1.0;

      # ==========================================
      # Blur
      # ==========================================

      blur = 1;
      blur_layer = 1;
      blur_optimized = 1;

      blur_params = {
        radius = 6;
        num_passes = 3;
        brightness = 0.85;
        contrast = 0.9;
        saturation = 1.0;
        noise = 0.02;
      };

      # ==========================================
      # Shadows
      # ==========================================

      shadows = 1;
      layer_shadows = 1;
      shadow_only_floating = 1;

      shadows_size = 18;
      shadows_blur = 15;
      shadows_position_x = 0;
      shadows_position_y = 6;
      shadowscolor = "0x00000040";

      # ==========================================
      # Animations
      # ==========================================

      animations = 1;
      layer_animations = 1;

      animation_type_open = "slide";
      animation_type_close = "slide";

      animation_fade_in = 1;
      animation_fade_out = 1;

      tag_animation_direction = 1;

      zoom_initial_ratio = 0.3;
      zoom_end_ratio = 0.8;

      fadein_begin_opacity = 0.5;
      fadeout_begin_opacity = 0.8;

      animation_duration_move = 40;
      animation_duration_open = 100;
      animation_duration_tag = 50;
      animation_duration_close = 50;
      animation_duration_focus = 0;

      animation_curve = {
        open = "0.46,1.0,0.29,1";
        move = "0.46,1.0,0.29,1";
        tag = "0.46,1.0,0.29,1";
        close = "0.08,0.92,0,1";
        focus = "0.46,1.0,0.29,1";
        opafadeout = "0.5,0.5,0.5,0.5";
        opafadein = "0.46,1.0,0.29,1";
      };

      # ==========================================
      # Applications
      # ==========================================

      bind = [
        "SUPER,Return,spawn,alacritty"
        "SUPER,t,spawn,qs ipc call applauncher toggle"
        "SUPER+SHIFT,p,spawn,qs ipc call powermenu toggle"

        # Window Management
        "SUPER,q,killclient"
        "SUPER,s,togglefloating"
        "SUPER,f,togglefullscreen"
        "SUPER+SHIFT,r,reload_config"
        "SUPER+SHIFT,M,quit"

        # Focus Navigation
        "SUPER,Left,focusdir,left"
        "SUPER,Down,focusdir,down"
        "SUPER,Up,focusdir,up"
        "SUPER,Right,focusdir,right"
        "SUPER,h,focusdir,left"
        "SUPER,j,focusdir,down"
        "SUPER,k,focusdir,up"
        "SUPER,l,focusdir,right"
        "SUPER,Tab,focusstack,next"
        "ALT,Tab,view,-1"
        "SUPER+SHIFT,Tab,focusstack,prev"

        # Window Exchange
        "SUPER+SHIFT,Left,exchange_client,left"
        "SUPER+SHIFT,Down,exchange_client,down"
        "SUPER+SHIFT,Up,exchange_client,up"
        "SUPER+SHIFT,Right,exchange_client,right"
        "SUPER+SHIFT,h,exchange_client,left"
        "SUPER+SHIFT,j,exchange_client,down"
        "SUPER+SHIFT,k,exchange_client,up"
        "SUPER+SHIFT,l,exchange_client,right"

        # Window Resize
        "SUPER+CTRL,Left,resizewin,-20,0"
        "SUPER+CTRL,Right,resizewin,20,0"
        "SUPER+CTRL,Up,resizewin,0,-20"
        "SUPER+CTRL,Down,resizewin,0,20"
        "SUPER+CTRL,h,resizewin,-20,0"
        "SUPER+CTRL,l,resizewin,20,0"
        "SUPER+CTRL,k,resizewin,0,-20"
        "SUPER+CTRL,j,resizewin,0,20"

        # Tags / Workspaces
        "SUPER,1,view,1"
        "SUPER,2,view,2"
        "SUPER,3,view,3"
        "SUPER,4,view,4"
        "SUPER,5,view,5"
        "SUPER,6,view,6"
        "SUPER,7,view,7"
        "SUPER,8,view,8"
        "SUPER,9,view,9"

        "SUPER+SHIFT,1,tag,1"
        "SUPER+SHIFT,2,tag,2"
        "SUPER+SHIFT,3,tag,3"
        "SUPER+SHIFT,4,tag,4"
        "SUPER+SHIFT,5,tag,5"
        "SUPER+SHIFT,6,tag,6"
        "SUPER+SHIFT,7,tag,7"
        "SUPER+SHIFT,8,tag,8"
        "SUPER+SHIFT,9,tag,9"

        # Layouts
        "SUPER,space,switch_layout"
        "SUPER+SHIFT,t,setlayout,dwindle"
        "SUPER,t,setlayout,tile"
        "SUPER,a,setlayout,scroller"
        "SUPER,m,setlayout,monocle"
        "SUPER,o,toggleoverview"

        "SUPER,g,togglegaps"
        "SUPER+SHIFT,g,toggleglobal"
        "SUPER,bracketleft,setmfact,-0.05"
        "SUPER,bracketright,setmfact,+0.05"
        "SUPER,r,switch_proportion_preset"

        # Screenshots & Media
        "NONE,Print,spawn_shell,grim - | tee ~/pictures/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy && notify-send \"screenshot\" \"screen captured\""
        "SUPER+SHIFT,s,spawn_shell,grim -g \"$(slurp)\" - | tee ~/pictures/screenshots/$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy && notify-send \"screenshot\" \"area captured\""

        "NONE,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        "NONE,XF86AudioLowerVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-"
        "NONE,XF86AudioRaiseVolume,spawn,wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+"
        "NONE,XF86MonBrightnessUp,spawn,brightnessctl set +5%"
        "NONE,XF86MonBrightnessDown,spawn,brightnessctl set 5%-"

        # Mouse / Axis
        "SUPER+CTRL,r,reload_config"
      ];

      # ==========================================
      # Gestures
      # ==========================================

      gesturebind = [
        "none,left,3,viewtoleft_have_client"
        "none,right,3,viewtoright_have_client"
        "none,up,3,toggleoverview"
        "none,down,3,toggleoverview"
      ];

      # ==========================================
      # Mouse
      # ==========================================

      mousebind = [
        "SUPER,btn_left,moveresize,curmove"
        "SUPER,btn_right,moveresize,curresize"
      ];

      axisbind = [
        "SUPER,UP,viewtoleft_have_client"
        "SUPER,DOWN,viewtoright_have_client"
      ];

      # ==========================================
      # Input
      # ==========================================

      repeat_rate = 50;
      repeat_delay = 300;

      disable_trackpad = 0;
      tap_to_click = 1;
      tap_and_drag = 1;
      drag_lock = 0;
      trackpad_natural_scrolling = 0;

      cursor_theme = "Bibata-Modern-Ice";
      cursor_size = 24;
      cursor_hide_timeout = 0;


      allow_tearing = 1;

      # ==========================================
      # Languages
      # ==========================================

      xkb_rules_layout = "us,us";
      xkb_rules_variant = "altgr-intl, colemak_dh";
      xkb_rules_options = "grp:alt_shift_toggle";

      # ==========================================
      # Misc / Focus
      # ==========================================

      axis_bind_apply_timeout = 100;
      focus_on_activate = 1;
      idleinhibit_ignore_visible = 0;
      sloppyfocus = 1;
      warpcursor = 1;

      focus_cross_monitor = 0;
      focus_cross_tag = 0;

      enable_floating_snap = 1;
      snap_distance = 30;
      drag_tile_to_tile = 1;

      xwayland_persistence = 1;

      # ==========================================
      # Layout
      # ==========================================

      new_is_master = 0;
      default_mfact = 0.55;
      default_nmaster = 1;
      smartgaps = 0;

      circle_layout = "tile,scroller,grid,deck,monocle,center_tile,vertical_tile,vertical_scroller,vertical_grid,vertical_deck,right_tile,tgmix,dwindle,canvas";

      # ==========================================
      # Scroller
      # ==========================================

      scroller_structs = 20;
      scroller_default_proportion = 1.0;
      scroller_focus_center = 1;
      scroller_prefer_center = 1;
      edge_scroller_pointer_focus = 1;
      scroller_default_proportion_single = 1.0;
      scroller_proportion_preset = "0.5,1.0";

      # ==========================================
      # Overview
      # ==========================================

      enable_hotarea = 0;
      overviewgappi = 5;
      overviewgappo = 30;

      # ==========================================
      # Monitor
      # ==========================================

      monitorrule = [
        "name:^eDP-1$,width:1920,height:1080,refresh:75,x:0,y:0,scale:1.0"
      ];

      # ==========================================
      # Tag Rules
      # ==========================================

      tagrule = [
        "id:1,layout_name:monocle"
        "id:2,layout_name:scroller"
        "id:3,layout_name:tile"
        "id:4,layout_name:scroller"
        "id:5,layout_name:scroller"
        "id:6,layout_name:monocle"
      ];

      # ==========================================
      # Window Rules
      # ==========================================

      windowrule = [
        "appid:thunar,focused_opacity:0.80"
        "appid:thunar,unfocused_opacity:0.80"

        # Simple Floating Tools
        "isfloating:1,appid:org.pulseaudio.pavucontrol"
        "isfloating:1,appid:org.quickshell,title:^Network$"

        # Native GTK & XDG Desktop Portals / File Selection Dialogs
        "isfloating:1,appid:xdg-desktop-portal-gtk"
        "isfloating:1,width:816,height:537,appid:dialog"
        "isfloating:1,title:Open File"
        "isfloating:1,title:Select a File"
        "isfloating:1,title:Choose wallpaper"
        "isfloating:1,title:Save As"

        # Other Window Rules
        "animation_type_open:zoom,animation_type_close:zoom,appid:mpv"
      ];
    };
  };
}
