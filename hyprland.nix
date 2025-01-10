{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    xwayland.enable = true;

    settings = {
      "$mod" = "SUPER";

      misc = {
        disable_splash_rendering = true;
        disable_hyprland_logo = true;
      };

      monitor = [
        "DP-1,preferred,auto,1"
        "DP-2,preferred,auto-up,1,transform,2"
      ];

      exec-once = [
        "${pkgs.hyprpaper}/bin/hyprpaper"
        "pkill waybar & sleep 0.5 && waybar"
        "hypridle"
        "[workspace special:terminal silent] ghostty"
      ];

      # Basic window management
      bind = [
        # Application launchers
        "$mod, grave, togglespecialworkspace, terminal"
        "$mod, Space, exec, rofi -show drun"
        "$mod, B, exec, firefox"

        # media keys
        ",XF86AudioRaiseVolume, exec, pamixer --increase 3"
        ",XF86AudioLowerVolume, exec, pamixer --decrease 3"

        # Window management
        "$mod, Q, killactive"
        "$mod, F, fullscreen"

        # Focus
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"

        # Move windows
        "$mod SHIFT, left, movewindow, l"
        "$mod SHIFT, right, movewindow, r"
        "$mod SHIFT, up, movewindow, u"
        "$mod SHIFT, down, movewindow, d"
        "$mod SHIFT, f, togglefloating"

        # Workspaces
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"

        # Move windows to workspaces
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"

        # Resize window width
        "$mod, bracketleft, resizeactive, -30 0"
        "$mod, bracketright, resizeactive, 30 0"

        # lock and logout
        "$mod SHIFT, Q, exec, hyprlock" # Super + Shift + Q to lock screen
        "$mod SHIFT, E, exit" # Super + Shift + E to log out to SDDM
        
        # screenshot
        "$mod SHIFT, X, exec, hyprshot -m region --clipboard-only" # Super + Shift + X to take screenshot
      ];

      # Window rules
      windowrule = [
        "float, ^(rofi|plexamp)$"
        "float, ^(ghostty)$"
        "workspace special:terminal, ^(ghostty)$"
        "size 100% 50%, ^(ghostty)$"
        "move 50% 0%, ^(ghostty)$"
      ];

      # Some default env vars
      env = [
        "XCURSOR_SIZE,24"
        "GTK_THEME,Adwaita:dark"
      ];

      # Basic appearances
      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee)";
        "col.inactive_border" = "rgba(595959aa)";
      };
    };
  };

  home.file.".config/hypr/hyprpaper.conf".text = ''
    preload = ~/nixos-config/wallpapers/big-mountain.jpg
    wallpaper = ,~/nixos-config/wallpapers/big-mountain.jpg
  '';

  home.file.".config/hypr/hypridle.conf".text = ''
    general {
        lock_cmd = hyprlock
        before_sleep_cmd = hyprlock
        after_sleep_cmd = hyprctl dispatch dpms on
        ignore_dbus_inhibit = false
    }

    listener {
        timeout = 900
        on-timeout = hyprlock
    }

    listener {
        timeout = 1200
        on-timeout = hyprctl dispatch dpms off
        on-resume = hyprctl dispatch dpms on
    }
  '';

  home.file.".config/hypr/hyprlock.conf".text = ''
    background {
        monitor =
        path = ~/nixos-config/wallpapers/big-mountain.jpg
        blur_size = 4
        blur_passes = 3
    }
    
    input-field {
        monitor =
        size = 300, 50
        outline_thickness = 2
        dots_size = 0.2
        dots_spacing = 0.15
        dots_center = true
        outer_color = rgba(33, 33, 33, 0.5)
        inner_color = rgba(200, 200, 200, 0.5)
        font_color = rgb(200, 200, 200)
        fade_on_empty = true
        placeholder_text = <i>Password...</i>
        hide_input = false
        position = 0, -20
        halign = center
        valign = center
    }
    
    label {
        monitor =
        text = $TIME
        color = rgba(200, 200, 200, 1.0)
        font_size = 50
        position = 0, -100
        halign = center
        valign = center
    }
  '';

  services.mako  = {
    enable = true;
    actions = true;
    borderRadius = 8;
    borderSize = 1;
    defaultTimeout = 10000;
    icons = true;
    layer = "overlay";
    maxVisible = 3;
    padding = "10";
    width = 300;
  };
}
