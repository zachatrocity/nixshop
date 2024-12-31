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
        # other startup commands...
      ];

      # Basic window management
      bind = [
        # Application launchers
        "$mod, RETURN, exec, ghostty"
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

        # logout
        "$mod SHIFT, Q, exit" # Super + Shift + Q will log out to SDDM
      ];

      # Window rules
      windowrule = [
        "float, ^(rofi|plexamp)$"
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

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };

      listener = [
        {
          timeout = 900;
          on-timeout = "hyprlock";
        }
        {
          timeout = 1200;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };

  services.mako  = {
    enable = true;
    catppuccin.enable = true;
    actions = true;
    borderRadius = 8;
    borderSize = 1;
    defaultTimeout = 10000;
    font = "${theme.fonts.default.name}";
    iconPath = "${theme.iconTheme.iconPath}";
    icons = true;
    layer = "overlay";
    maxVisible = 3;
    padding = "10";
    width = 300;
  };
}
