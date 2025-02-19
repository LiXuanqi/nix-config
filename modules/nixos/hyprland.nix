{ inputs, pkgs, ... }:
# let
#   hyprland = inputs.hyprland.packages.${pkgs.system}.hyprland;
#   plugins = inputs.hyprland-plugins.packages.${pkgs.system};

#   launcher = pkgs.writeShellScriptBin "hypr" ''
#     #!/${pkgs.bash}/bin/bash

#     export WLR_NO_HARDWARE_CURSORS=1
#     export _JAVA_AWT_WM_NONREPARENTING=1

#     exec ${hyprland}/bin/Hyprland
#   '';
# in
{
  # home.packages = with pkgs; [
  #   launcher
  #   adoptopenjdk-jre-bin
  # ];

  # xdg.desktopEntries."org.gnome.Settings" = {
  #   name = "Settings";
  #   comment = "Gnome Control Center";
  #   icon = "org.gnome.Settings";
  #   exec = "env XDG_CURRENT_DESKTOP=gnome ${pkgs.gnome.gnome-control-center}/bin/gnome-control-center";
  #   categories = [ "X-Preferences" ];
  #   terminal = false;
  # };

  # programs = {
  #   swaylock = {
  #     enable = true;
  #     package = pkgs.swaylock-effects;
  #   };
  # };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
    ];
    settings = {
      env = [
        "XCURSOR_SIZE, 24"
        "HYPRCURSOR_SIZE, 24"
      ];
      monitor = [
        ",preferred,auto,1"
        # ",addreserved,35,0,0,0"
      ];
      "exec-once" = [
        # "waybar"
        "dunst"
        "fcitx5"
        "ags run"
        # "swww kill; swww init"
        # ''
        #   swayidle -w timeout 300 'swaylock -f' timeout 450 'pidof java || systemctl suspend' before-sleep 'swaylock -f'
        # ''
        # "wl-paste --type text --watch cliphist store"
        # "wl-paste --type image --watch cliphist store"
        # "hyprctl setcursor Bibata-Modern-Classic 24"
      ];
      general = {
        gaps_in = 4;
        gaps_out = 5;
        gaps_workspaces = 50;
        border_size = 1;
        layout = "dwindle";
        resize_on_border = true;
        "col.active_border" = "rgba(471868FF)";
        "col.inactive_border" = "rgba(4f4256CC)";
        "no_border_on_floating" = false;
      };
      dwindle = {
        preserve_split = true;
        smart_resizing = false;
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_distance = 700;
        workspace_swipe_fingers = 4;
        workspace_swipe_cancel_ratio = 0.2;
        workspace_swipe_min_speed_to_force = 5;
        workspace_swipe_direction_lock = true;
        workspace_swipe_direction_lock_threshold = 10;
        workspace_swipe_create_new = true;
      };
      binds = {
        scroll_event_delay = 0;
      };
      input = {
        # Keyboard: Add a layout and uncomment kb_options for Win+Space switching shortcut
        kb_layout = "us";
        kb_options = "caps:swapescape";
        # kb_options = grp:win_space_toggle;
        numlock_by_default = true;
        repeat_delay = 250;
        repeat_rate = 35;

        touchpad = {
          natural_scroll = true;
          disable_while_typing = true;
          clickfinger_behavior = true;
          scroll_factor = 0.5;
        };

        # special_fallthrough = true   # only in new hyprland versions. but they're hella fucked
        follow_mouse = 1;
      };
      decoration = {
        rounding = 20;

        blur = {
          enabled = true;
          xray = true;
          special = false;
          new_optimizations = true;
          size = 5;
          passes = 4;
          brightness = 1;
          noise = 1.0e-2;
          contrast = 1;
        };
        # Shadow
        shadow = {
          enabled = true;
          range = 20;
          render_power = 3;
        };
        # drop_shadow = false;
        # shadow_ignore_window = true;
        # shadow_offset = "0 2";
        # "col.shadow" = "rgba(0000001A)";

        # Dim
        dim_inactive = false;
        dim_strength = 0.1;
        dim_special = 0;
      };
      animations = {
        enabled = true;
        bezier = [
          "md3_decel, 0.05, 0.7, 0.1, 1"
          "md3_accel, 0.3, 0, 0.8, 0.15"
          "overshot, 0.05, 0.9, 0.1, 1.1"
          "crazyshot, 0.1, 1.5, 0.76, 0.92"
          "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
          "fluent_decel, 0.1, 1, 0, 1"
          "easeInOutCirc, 0.85, 0, 0.15, 1"
          "easeOutCirc, 0, 0.55, 0.45, 1"
          "easeOutExpo, 0.16, 1, 0.3, 1"
        ];
        animation = [
          "windows, 1, 3, md3_decel, popin 60%"
          "border, 1, 10, default"
          "fade, 1, 2.5, md3_decel"
          # "workspaces, 1, 3.5, md3_decel, slide"
          "workspaces, 1, 7, fluent_decel, slide"
          # "workspaces, 1, 7, fluent_decel, slidefade 15%"
          # "specialWorkspace, 1, 3, md3_decel, slidefadevert 15%"
          "specialWorkspace, 1, 3, md3_decel, slidevert"
        ];
      };
      misc = {
        vfr = 1;
        vrr = 1;
        # layers_hog_mouse_focus = true;
        focus_on_activate = true;
        animate_manual_resizes = false;
        animate_mouse_windowdragging = false;
        enable_swallow = false;
        swallow_regex = "(foot|kitty|allacritty|Alacritty)";

        disable_hyprland_logo = true;
        new_window_takes_over_fullscreen = 2;
      };
      debug = {
        # overlay = true;
        # damage_tracking = 0;
        # damage_blink = true;
      };
      bind =
        let
          SLURP_COMMAND = "$(slurp -d -c eedcf5BB -b 4f425644 -s 00000000)";
          MAIN_MODE = "SUPER";
          APP_LAUNCHER = "rofi -show drun -show-icons";
        in
        [
          "${MAIN_MODE}, Q, exec, wezterm"
          "${MAIN_MODE}, C, killactive"
          "${MAIN_MODE}, M, exit"
          "${MAIN_MODE}, SPACE, exec, ${APP_LAUNCHER}"
          # window manage
          "${MAIN_MODE}, V, togglefloating"
          "${MAIN_MODE}, J, togglesplit"

          # Move focus with mainMod + arrow keys
          "${MAIN_MODE}, left, movefocus, l"
          "${MAIN_MODE}, right, movefocus, r"
          "${MAIN_MODE}, up, movefocus, u"
          "${MAIN_MODE}, down, movefocus, d"
          # Switch workspaces with mainMod + [0-9]
          "${MAIN_MODE}, 1, workspace, 1"
          "${MAIN_MODE}, 2, workspace, 2"
          "${MAIN_MODE}, 3, workspace, 3"
          "${MAIN_MODE}, 4, workspace, 4"
          "${MAIN_MODE}, 5, workspace, 5"
          "${MAIN_MODE}, 6, workspace, 6"
        ];
      bindm =
        let
          MAIN_MODE = "SUPER";
        in
        [
          # Move/resize windows with mainMod + LMB/RMB and dragging
          ''${MAIN_MODE}, mouse:272, movewindow''
          ''${MAIN_MODE}, mouse:273, resizewindow''
        ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];
      bindl = [
      ];
      bindle = [
      ];
      bindr = [
      ];
      bindir = [ ];
      binde = [
      ];
      windowrule = [
      ];
      windowrulev2 = [ ];
      layerrule = [
      ];
      source = [
        # "./colors.conf"
      ];
      plugin = {
        hyprbars = {
          bar_color = "rgb(2a2a2a)";
          bar_height = 28;
          col_text = "rgba(ffffffdd)";
          bar_text_size = 11;
          bar_text_font = "Ubuntu Nerd Font";

          # Disable hyprbars for floating windows if you prefer
          disable_floating = true;

          buttons = {
            button_size = 11;
            "col.maximize" = "rgba(ffffff11)";
            "col.close" = "rgba(ff111133)";
          };
        };
      };
    };
  };
}
