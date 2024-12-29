# waybar.nix
{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.override {
      hyprlandSupport = true;
    };
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        spacing = 4;
        margin-top = 0;
        margin-left = 0;
        margin-right = 0;
        
        modules-left = ["hyprland/workspaces"];
        modules-center = ["clock"];
        modules-right = ["pulseaudio" "network" "battery" "tray"];
        
        "hyprland/workspaces" = {
          format = "•";
          on-click = "activate";
          all-outputs = true;
          active-only = false;
          show-special = false;
        };
        
        "clock" = {
          format = "{:%I:%M %p}";
          format-alt = "{:%e %b %Y}";
          tooltip = false;
        };
        
        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "󰝟";
          format-icons = {
            default = ["" "" ""];
          };
          on-click = "pavucontrol";
        };
        
        "network" = {
          format-wifi = "󰤨";
          format-ethernet = "󰈀";
          format-disconnected = "󰤭";
          tooltip-format = "{essid}";
        };
        
        "battery" = {
          format = "{icon} {capacity}%";
          format-icons = ["" "" "" "" ""];
          states = {
            warning = 30;
            critical = 15;
          };
        };
        
        "tray" = {
          icon-size = 16;
          spacing = 10;
        };
      };
    };
    
    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
        min-height: 0;
        border: none;
        border-radius: 0;
      }
      
      window#waybar {
        background: rgba(255, 255, 255, 0.2);
        color: #262626;
        backdrop-filter: blur(10px);
      }
      
      window#waybar.hidden {
        opacity: 0.2;
      }
      
      #workspaces {
        margin: 0 4px;
      }
      
      #workspaces button {
        all: unset;
        color: #262626;
        padding: 0 4px;
      }
      
      #workspaces button.active {
        color: #0066CC;
      }
      
      #clock,
      #battery,
      #pulseaudio,
      #network,
      #tray {
        padding: 0 8px;
        color: #262626;
      }
      
      #battery.warning {
        color: #ff9400;
      }
      
      #battery.critical {
        color: #ff0000;
      }
      
      #tray {
        margin-right: 4px;
      }
      
      #tray > .passive {
        -gtk-icon-effect: dim;
      }
      
      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
      }
    '';
  };
}