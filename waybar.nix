# waybar.nix
{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.override {
      hyprlandSupport = true;  # Add this line
    };
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        modules-left = ["hyprland/workspaces"];
        modules-center = ["clock"];
        modules-right = ["pulseaudio" "network" "battery" "tray"];
        
        "hyprland/workspaces" = {
          format = "{name}";
          on-click = "activate";
        };
        
        "clock" = {
          format = "{:%I:%M %p}";
          format-alt = "{:%Y-%m-%d}";
        };
        
        "pulseaudio" = {
          format = "{volume}% {icon}";
          format-muted = "🔇";
          format-icons = {
            default = ["" "" ""];
          };
        };
        
        "network" = {
          format-wifi = "{essid} ({signalStrength}%) ";
          format-ethernet = "Connected ";
          format-disconnected = "Disconnected ⚠";
        };
        
        "battery" = {
          format = "{capacity}% {icon}";
          format-icons = ["" "" "" "" ""];
        };
        
        "tray" = {
          spacing = 10;
        };
      };
    };
    
    style = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(21, 18, 27, 0.9);
        color: #cdd6f4;
      }

      #workspaces button {
        padding: 5px;
        color: #313244;
        margin-right: 5px;
      }

      #workspaces button.active {
        color: #a6adc8;
        background: #313244;
      }

      #clock,
      #battery,
      #pulseaudio,
      #network,
      #workspaces,
      #tray {
        padding: 0 10px;
      }
    '';
  };
}