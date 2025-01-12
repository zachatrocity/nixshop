{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.override {
      hyprlandSupport = true;
    };
    style = ''
             * {
               font-family: "JetBrainsMono Nerd Font";
               font-size: 12pt;
               font-weight: bold;
               border-radius: 8px;
               transition-property: background-color;
               transition-duration: 0.5s;
             }
             @keyframes blink_red {
               to {
                 background-color: rgb(242, 143, 173);
                 color: rgb(26, 24, 38);
               }
             }
             .warning, .critical, .urgent {
               animation-name: blink_red;
               animation-duration: 1s;
               animation-timing-function: linear;
               animation-iteration-count: infinite;
               animation-direction: alternate;
             }
             window#waybar {
               background-color: transparent;
             }
             window > box {
               margin-left: 5px;
               margin-right: 5px;
               margin-top: 5px;
               background-color: #1e1e2a;
               padding: 3px;
               padding-left:8px;
               border: 2px none #33ccff;
             }
       #workspaces {
               padding-left: 0px;
               padding-right: 4px;
             }
       #workspaces button {
               padding-top: 5px;
               padding-bottom: 5px;
               padding-left: 6px;
               padding-right: 6px;
             }
       #workspaces button.active {
               background-color: rgb(181, 232, 224);
               color: rgb(26, 24, 38);
             }
       #workspaces button.urgent {
               color: rgb(26, 24, 38);
             }
       #workspaces button:hover {
               background-color: rgb(248, 189, 150);
               color: rgb(26, 24, 38);
             }
             tooltip {
               background: rgb(48, 45, 65);
             }
             tooltip label {
               color: rgb(217, 224, 238);
             }
       #custom-launcher {
               font-size: 20px;
               padding-left: 8px;
               padding-right: 6px;
               color: #7ebae4;
             }
       #mode, #clock, #memory, #temperature,#cpu,#mpd, #custom-wall, #temperature, #backlight, #pulseaudio, #network, #battery, #custom-powermenu, #custom-cava-internal {
               padding-left: 10px;
               padding-right: 10px;
             }
             /* #mode { */
             /* 	margin-left: 10px; */
             /* 	background-color: rgb(248, 189, 150); */
             /*     color: rgb(26, 24, 38); */
             /* } */
       #memory {
               color: rgb(181, 232, 224);
             }
       #cpu {
               color: rgb(245, 194, 231);
             }
       #clock {
               color: rgb(217, 224, 238);
             }
       #idle_inhibitor {
               padding-left: 10px;
               padding-right: 10px;
               color: #f5c2e7;
             }
       #custom-wall {
               color: #33ccff;
          }
       #temperature {
               color: rgb(150, 205, 251);
             }
       #backlight {
               color: rgb(248, 189, 150);
             }
       #pulseaudio {
          color: rgb(19, 151, 212);
        }
       #pulseaudio {
               color: rgb(245, 224, 220);
             }
       #network {
               color: #ABE9B3;
             }
       #network.disconnected {
               color: rgb(255, 255, 255);
             }
       #custom-powermenu {
               color: rgb(242, 143, 173);
               padding-right: 8px;
             }
       #tray {
               padding-right: 8px;
               padding-left: 10px;
             }
       #mpd.paused {
               color: #414868;
               font-style: italic;
             }
       #mpd.stopped {
               background: transparent;
             }
       #mpd {
               color: #c0caf5;
             }
       #custom-cava-internal{
               font-family: "Hack Nerd Font" ;
               color: #33ccff;
             }
    '';
    settings = [
      {
        "layer" = "top";
        "position" = "top";
        modules-left = [
          "custom/launcher"
          "temperature"
          "mpd"
          "custom/cava-internal"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "bluetooth"
          "pulseaudio"
          "backlight"
          "memory"
          "cpu"
          "network"
          "idle_inhibitor"
          "custom/powermenu"
          "tray"
        ];
        "custom/launcher" = {
          "format" = " ";
          "on-click" = "pkill rofi || rofi2";
          "on-click-middle" = "exec default_wall";
          "on-click-right" = "exec wallpaper_random";
          "tooltip" = false;
        };
        "custom/cava-internal" = {
          "exec" = "sleep 1s && cava-internal";
          "tooltip" = false;
        };
        "bluetooth" = {
          "format" = " {status}";
          "format-connected" = " {num_connections}";
          "tooltip-format" = "{device_alias}";
          "tooltip-format-connected" = " {device_enumerate}";
          "tooltip-format-enumerate-connected" = "{device_alias}";
          "on-click" = "blueman-manager";
        };
        "pulseaudio" = {
          "scroll-step" = 1;
          "format" = "{icon} {volume}%";
          "format-muted" = "󰖁 Muted";
          "format-icons" = {
            "default" = [
              ""
              ""
              ""
            ];
          };
          "on-click" = "pamixer -t";
          "tooltip" = false;
        };
        "clock" = {
          "interval" = 1;
          "format" = "{:%I:%M %p  %A %b %d}";
          "tooltip" = true;
          "tooltip-format" = "{=%A; %d %B %Y}\n<tt>{calendar}</tt>";
        };
        "memory" = {
          "interval" = 1;
          "format" = "󰻠 {percentage}%";
          "states" = {
            "warning" = 85;
          };
        };
        "cpu" = {
          "interval" = 1;
          "format" = "󰍛 {usage}%";
        };
        "mpd" = {
          "max-length" = 25;
          "format" = "<span foreground='#bb9af7'></span> {title}";
          "format-paused" = " {title}";
          "format-stopped" = "<span foreground='#bb9af7'></span>";
          "format-disconnected" = "";
          "on-click" = "mpc --quiet toggle";
          "on-click-right" = "mpc update; mpc ls | mpc add";
          "on-click-middle" = "kitty --class='ncmpcpp' ncmpcpp ";
          "on-scroll-up" = "mpc --quiet prev";
          "on-scroll-down" = "mpc --quiet next";
          "smooth-scrolling-threshold" = 5;
          "tooltip-format" = "{title} - {artist} ({elapsedTime:%M:%S}/{totalTime:%H:%M:%S})";
        };
        "network" = {
          "format-disconnected" = "󰯡 Disconnected";
          "format-ethernet" = "󰒢 Connected!";
          "format-linked" = "󰖪 {essid} (No IP)";
          "format-wifi" = "󰖩 {essid}";
          "interval" = 1;
          "tooltip" = false;
        };
        "custom/powermenu" = {
          "format" = "";
          "on-click" = "pkill rofi || ~/.config/rofi/powermenu/type-3/powermenu.sh";
          "tooltip" = false;
        };
        "tray" = {
          "icon-size" = 15;
          "spacing" = 5;
        };
        "idle_inhibitor" = {
          "format" = "{icon}";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
          "tooltip" = false;
        };
      }
    ];
  };

  home.file.".config/cava/config".text = ''
    ## Configuration file for CAVA. Default values are commented out. Use either ';' or '#' for commenting.


    [general]

    # Smoothing mode. Can be 'normal', 'scientific' or 'waves'. DEPRECATED as of 0.6.0
    ; mode = normal

    # Accepts only non-negative values.
    ; framerate = 60

    # 'autosens' will attempt to decrease sensitivity if the bars peak. 1 = on, 0 = off
    # new as of 0.6.0 autosens of low values (dynamic range)
    # 'overshoot' allows bars to overshoot (in % of terminal height) without initiating autosens. DEPRECATED as of 0.6.0
    ; autosens = 1
    ; overshoot = 20

    # Manual sensitivity in %. If autosens is enabled, this will only be the initial value.
    # 200 means double height. Accepts only non-negative values.
    ; sensitivity = 100

    # The number of bars (0-200). 0 sets it to auto (fill up console).
    # Bars' width and space between bars in number of characters.
    bars = 12
    ; bar_width = 2
    ; bar_spacing = 1
    # bar_height is only used for output in "noritake" format
    ; bar_height = 32

    # For SDL width and space between bars is in pixels, defaults are:
    ; bar_width = 20
    ; bar_spacing = 5


    # Lower and higher cutoff frequencies for lowest and highest bars
    # the bandwidth of the visualizer.
    # Note: there is a minimum total bandwidth of 43Mhz x number of bars.
    # Cava will automatically increase the higher cutoff if a too low band is specified.
    ; lower_cutoff_freq = 50
    ; higher_cutoff_freq = 10000


    # Seconds with no input before cava goes to sleep mode. Cava will not perform FFT or drawing and
    # only check for input once per second. Cava will wake up once input is detected. 0 = disable.
    sleep_timer = 10


    [input]

    # Audio capturing method. Possible methods are: 'pulse', 'alsa', 'fifo', 'sndio' or 'shmem'
    # Defaults to 'pulse', 'alsa' or 'fifo', in that order, dependent on what support cava was built with.
    #
    # All input methods uses the same config variable 'source'
    # to define where it should get the audio.
    #
    # For pulseaudio 'source' will be the source. Default: 'auto', which uses the monitor source of the default sink
    # (all pulseaudio sinks(outputs) have 'monitor' sources(inputs) associated with them).
    #
    # For alsa 'source' will be the capture device.
    # For fifo 'source' will be the path to fifo-file.
    # For shmem 'source' will be /squeezelite-AA:BB:CC:DD:EE:FF where 'AA:BB:CC:DD:EE:FF' will be squeezelite's MAC address
    ; method = pulse
    ; source = auto

    ; method = alsa
    ; source = hw:Loopback,1

    ; method = fifo
    ; source = /tmp/mpd.fifo
    ; sample_rate = 44100
    ; sample_bits = 16

    ; method = shmem
    ; source = /squeezelite-AA:BB:CC:DD:EE:FF

    ; method = portaudio
    ; source = auto


    [output]

    # Output method. Can be 'ncurses', 'noncurses', 'raw', 'noritake' or 'sdl'.
    # 'noncurses' uses a custom framebuffer technique and prints only changes
    # from frame to frame in the terminal. 'ncurses' is default if supported.
    #
    # 'raw' is an 8 or 16 bit (configurable via the 'bit_format' option) data
    # stream of the bar heights that can be used to send to other applications.
    # 'raw' defaults to 200 bars, which can be adjusted in the 'bars' option above.
    #
    # 'noritake' outputs a bitmap in the format expected by a Noritake VFD display
    #  in graphic mode. It only support the 3000 series graphical VFDs for now.
    #
    # 'sdl' uses the Simple DirectMedia Layer to render in a graphical context.
    method = raw

    # Visual channels. Can be 'stereo' or 'mono'.
    # 'stereo' mirrors both channels with low frequencies in center.
    # 'mono' outputs left to right lowest to highest frequencies.
    # 'mono_option' set mono to either take input from 'left', 'right' or 'average'.
    # set 'reverse' to 1 to display frequencies the other way around.
    ; channels = stereo
    ; mono_option = average
    ; reverse = 0

    # Raw output target. A fifo will be created if target does not exist.
    ; raw_target = /dev/stdout

    # Raw data format. Can be 'binary' or 'ascii'.
    data_format = ascii

    # Binary bit format, can be '8bit' (0-255) or '16bit' (0-65530).
    ; bit_format = 16bit

    # Ascii max value. In 'ascii' mode range will run from 0 to value specified here
    ascii_max_range = 7

    # Ascii delimiters. In ascii format each bar and frame is separated by a delimiters.
    # Use decimal value in ascii table (i.e. 59 = ';' and 10 = '\n' (line feed)).
    ; bar_delimiter = 59
    ; frame_delimiter = 10

    # sdl window size and position. -1,-1 is centered.
    ; sdl_width = 1000
    ; sdl_height = 500
    ; sdl_x = -1
    ; sdl_y= -1

    # set label on bars on the x-axis. Can be 'frequency' or 'none'. Default: 'none'
    # 'frequency' displays the lower cut off frequency of the bar above.
    # Only supported on ncurses and noncurses output.
    ; xaxis = none

    # enable alacritty synchronized updates. 1 = on, 0 = off
    # removes flickering in alacritty terminal emeulator.
    # defaults to off since the behaviour in other terminal emulators is unknown
    ; alacritty_sync = 1

    [color]

    ; background = default
    ; foreground = default

    ; background = '#111111'
    ; foreground = '#33cccc'


    ; gradient = 0
    ; gradient_count = 8
    ; gradient_color_1 = '#59cc33'
    ; gradient_color_2 = '#80cc33'
    ; gradient_color_3 = '#a6cc33'
    ; gradient_color_4 = '#cccc33'
    ; gradient_color_5 = '#cca633'
    ; gradient_color_6 = '#cc8033'
    ; gradient_color_7 = '#cc5933'
    ; gradient_color_8 = '#cc3333'



    [smoothing]

    # Percentage value for integral smoothing. Takes values from 0 - 100.
    # Higher values means smoother, but less precise. 0 to disable.
    # DEPRECATED as of 0.8.0, use noise_reduction instead
    ; integral = 77

    # Disables or enables the so-called "Monstercat smoothing" with or without "waves". Set to 0 to disable.
    ; monstercat = 0
    ; waves = 0

    # Set gravity percentage for "drop off". Higher values means bars will drop faster.
    # Accepts only non-negative values. 50 means half gravity, 200 means double. Set to 0 to disable "drop off".
    # DEPRECATED as of 0.8.0, use noise_reduction instead
    ; gravity = 100


    # In bar height, bars that would have been lower that this will not be drawn.
    # DEPRECATED as of 0.8.0
    ; ignore = 0

    # Noise reduction, float 0 - 1. default 0.77
    # the raw visualization is very noisy, this factor adjusts the integral and gravity filters to keep the signal smooth
    # 1 will be very slow and smooth, 0 will be fast but noisy.
    ; noise_reduction = 0.77


    [eq]

    # This one is tricky. You can have as much keys as you want.
    # Remember to uncomment more then one key! More keys = more precision.
    # Look at readme.md on github for further explanations and examples.
    # DEPRECATED as of 0.8.0 can be brought back by popular request, open issue at:
    # https://github.com/karlstav/cava
    ; 1 = 1 # bass
    ; 2 = 1
    ; 3 = 1 # midtone
    ; 4 = 1
    ; 5 = 1 # treble

  '';
}
