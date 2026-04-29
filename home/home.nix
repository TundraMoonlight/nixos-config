{
    inputs,
    lib,
    pkgs,
    ...
}: {
    imports = [
        ./modules/core/default.nix

        inputs.zen-browser.homeModules.twilight
        inputs.nvf.homeManagerModules.default
        inputs.nixcord.homeModules.nixcord
    ];

    home.sessionVariables = {
        QT_QPA_PLATFORMTHEME = "qt6ct";
        XDG_MENU_PREFIX = "plasma-";
    };

    home.packages = [
        pkgs.krita
        pkgs.cava
        pkgs.inter
        pkgs.jq
        pkgs.hyprshot
        pkgs.ffmpeg
        pkgs.wev
        pkgs.libnotify
        pkgs.darkly
        pkgs.darkly-qt5
        pkgs.fontconfig
        pkgs.wine-staging
        pkgs.bubblewrap
        pkgs.gamescope
        pkgs.steam
        pkgs.qt6Packages.qt6ct

        pkgs.nerd-fonts.blex-mono
        pkgs.nerd-fonts.liberation
        pkgs.nerd-fonts.fira-code
        pkgs.nerd-fonts.adwaita-mono
        pkgs.nerd-fonts.inconsolata
        pkgs.nerd-fonts.jetbrains-mono
        pkgs.nerd-fonts.lilex
        pkgs.nerd-fonts.commit-mono
        pkgs.nerd-fonts.space-mono
        pkgs.maple-mono.NF
        pkgs.atkinson-hyperlegible-next
        pkgs.atkinson-hyperlegible-mono

        inputs.qml-niri.packages.x86_64-linux.quickshell
        inputs.awww.packages.x86_64-linux.default
        inputs.lutgen-studio.packages.x86_64-linux.lutgen-studio
        inputs.accela.packages.x86_64-linux.default
        inputs.helium.packages.x86_64-linux.default
    ];

    # systemd = {
    #   user.services = {
    #     quickshell = {
    #       Unit = {
    #         Description = "Quickshell";
    #         After = [ "graphical-session.target" ];
    #       };
    #
    #       Service = {
    #         ExecStart = "${pkgs.quickshell}/bin/qs";
    #         Restart = "always";
    #         RestartSec = 1;
    #       };
    #
    #       Install = {
    #         WantedBy = ["graphical-session.target"];
    #       };
    #     };
    #   };
    # };

    xdg = {
        enable = true;
        terminal-exec.enable = true;

        portal = {
            enable = true;
            extraPortals = with pkgs;
                lib.mkForce [
                    xdg-desktop-portal-hyprland
                    xdg-desktop-portal-gtk
                ];

            config = {
                common = {
                    default = [
                        "hyprland"
                        "gtk"
                    ];
                };
            };
        };

        terminal-exec = {
            settings = {
                default = ["com.mitchellh.ghostty.desktop"];
            };
        };

        desktopEntries = {
            zen-twilight = {
                type = "Application";
                name = "Zen Browser";
                exec = "zen-twilight";
                icon = "zen-browser";
            };
            equibop = {
                type = "Application";
                name = "Discord";
                exec = "equibop";
                icon = "discord";
            };
            discord = {
                name = "Discord";
                noDisplay = true;
            };
            rmpc = {
                name = "rmpc";
                exec = "ghostty -e rmpc";
                terminal = true;
                icon = "gnome-music";
            };
            "org.gnome.Nautilus" = {
                name = "Files";
                exec = "dolphin";
                icon = "nautilus";
            };
        };
    };

    gtk = {
        enable = true;

        font.name = "Sunghyun Sans";
        iconTheme.name = "Colloid-Catppuccin";
        theme = null;
        colorScheme = "dark";

        gtk4 = {
            extraCss = ''
                @define-color accent_color #89b4fa;
                @define-color accent_fg_color #181825;
                @define-color accent_bg_color #89b4fa;
                @define-color window_bg_color #181825;
                @define-color window_fg_color #cdd6f4;
                @define-color headerbar_bg_color #181825;
                @define-color headerbar_fg_color #cdd6f4;
                @define-color popover_bg_color #1e1e2e;
                @define-color popover_fg_color #cdd6f4;
                @define-color view_bg_color #181825;
                @define-color view_fg_color #cdd6f4;
                @define-color card_bg_color #181825;
                @define-color card_fg_color #cdd6f4;
                @define-color sidebar_bg_color @window_bg_color;
                @define-color sidebar_fg_color @window_fg_color;
                @define-color sidebar_border_color @window_bg_color;
                @define-color sidebar_backdrop_color @window_bg_color;

                .navigation-sidebar .sidebar-row:selected {
                  color: #181825;
                  background-color: #89b4fa;
                  font-weight: 700;
                }

                #NautilusPathBar {
                  background-color: #1e1e2e;
                }

                .top-bar {
                  background-color: #181825;
                }

                filechooser placessidebar {
                    background-color: #ffffff;
                }
            '';
        };
    };

    qt = {
        style = {
            package = [
                pkgs.darkly-qt5
                pkgs.darkly
            ];
        };
        platformTheme = {
            name = "qtct";
        };
        qt6ctSettings = {
            Apperance = {
                style = "Darkly";
                icon_theme = "Colloid-Catppuccin-Dark";
                standar_dialogs = "xdgdesktopportal";
            };
        };
    };

    wayland = {
        windowManager = {
            hyprland = {
                enable = true;

                systemd.enable = false;

                settings = {
                    monitor = ",preferred,auto,auto";

                    "$terminal" = "ghostty";
                    "$fileManager" = "nautilus";
                    "$menu" = "rofi -show drun -theme '~/.config/rofi/themes/launcher.rasi'";
                    "$mainMod" = "SUPER";
                    "$altMod" = "ALT";

                    exec-once = [
                        "uwsm-app -- awww-daemon"
                        "awww restore"
                        "uwsm-app -- quickshell"
                    ];

                    env = [
                        "XCURSOR_SIZE,24"
                        "HYPRCURSOR_SIZE,16"
                        "HYPRCURSOR_THEME,catppuccin-mocha-dark-cursors"
                        "GDK_BACKEND,wayland,x11,*"
                        "QT_QPA_PLATFORM,wayland;xcb"
                        "SDL_VIDEODRIVER,wayland"
                        "CLUTTER_BACKEND,wayland"
                        "QT_QPA_PLATFORMTHEME,qt6ct"
                        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
                        "QT_QPA_PLATFORM,wayland;xcb"
                        "QT_AUTO_SCREEN_SCALE_FACTOR,1"
                    ];

                    general = {
                        gaps_in = 5;
                        gaps_out = 12;

                        border_size = 0;

                        #"col.active_border" = "rgba(89b4faff)";
                        #"col.inactive_border" = "rgba(00000000)";

                        layout = "scrolling";
                        allow_tearing = true;
                    };

                    decoration = {
                        rounding = 16;
                        rounding_power = 2;

                        # active_opacity = 0.85;
                        # inactive_opacity = 0.85;
                        #
                        # blur = {
                        #   enabled = true;
                        #
                        #   passes = 2;
                        #   size = 8;
                        #   contrast = 1.0;
                        #   brightness = 0.65;
                        #   vibrancy = 0.3;
                        # };
                    };

                    animations = {
                        enabled = true;

                        bezier = [
                            "linear, 0, 0, 1, 1"
                            "md3_standard, 0.2, 0, 0, 1"
                            "md3_decel, 0.05, 0.7, 0.1, 1"
                            "md3_accel, 0.3, 0, 0.8, 0.15"
                            "overshot, 0.05, 0.9, 0.1, 1.1"
                            "crazyshot, 0.1, 1.5, 0.76, 0.92"
                            "hyprnostretch, 0.05, 0.9, 0.1, 1.0"
                            "menu_decel, 0.1, 1, 0, 1"
                            "menu_accel, 0.38, 0.04, 1, 0.07"
                            "easeInOutCirc, 0.85, 0, 0.15, 1"
                            "easeOutCirc, 0, 0.55, 0.45, 1"
                            "easeOutExpo, 0.16, 1, 0.3, 1"
                            "softAcDecel, 0.26, 0.26, 0.15, 1"
                            "md2, 0.4, 0, 0.2, 1"
                        ];

                        animation = [
                            "windows, 1, 3, md3_decel, popin 60%"
                            "windowsIn, 1, 3, md3_decel, popin 60%"
                            "windowsOut, 1, 3, md3_accel, popin 60%"
                            "border, 1, 10, default"
                            "layersIn, 1, 3, menu_decel, slide"
                            "layersOut, 1, 1.6, menu_accel"
                            "fadeLayersIn, 1, 2, menu_decel"
                            "fadeLayersOut, 1, 4.5, menu_accel"
                            "workspaces, 1, 7, menu_decel, slidevert"
                            "specialWorkspace, 1, 3, md3_decel, slidevert"
                        ];
                    };

                    scrolling = {
                        fullscreen_on_one_column = true;
                        column_width = 0.8;
                        direction = "right";
                    };

                    misc = {
                        force_default_wallpaper = 0;
                        disable_hyprland_logo = true;
                    };

                    input = {
                        kb_layout = "us";
                        follow_mouse = 1;
                        sensitivity = 0.15;

                        touchpad = {
                            tap-and-drag = false;
                            natural_scroll = false;
                        };
                    };

                    xwayland = {
                        force_zero_scaling = true;
                    };

                    gesture = [
                        "3, vertical, workspace"
                        "3, left, dispatcher, layoutmsg, move +col"
                        "3, right, dispatcher, layoutmsg, move -col"
                        "3, pinchOut, float"
                        "4, left, dispatcher, layoutmsg, colresize -0.2"
                        "4, right, dispatcher, layoutmsg, colresize +0.2"
                    ];

                    bind = [
                        "$mainMod, T, exec, $terminal"
                        "$mainMod, Q, killactive,"

                        "$mainMod, W, exec, qs ipc call wallpaperSelector toggle"
                        "$mainMod, C, exec, qs ipc call clipboard toggle"

                        "$mainMod, left, movefocus, l&"
                        "$mainMod, right, movefocus, r"
                        "$mainMod, up, movefocus, u"
                        "$mainMod, down, movefocus, d"

                        "$mainMod, period, layoutmsg, move +col"
                        "$mainMod, comma, layoutmsg, move -col"
                        "$mainMod SHIFT, period, layoutmsg, swapcol r"
                        "$mainMod SHIFT, comma, layoutmsg, swapcol l"

                        "$mainMod, 1, workspace, 1"
                        "$mainMod, 2, workspace, 2"
                        "$mainMod, 3, workspace, 3"
                        "$mainMod, 4, workspace, 4"
                        "$mainMod, 5, workspace, 5"
                        "$mainMod, 6, workspace, 6"
                        "$mainMod, 7, workspace, 7"
                        "$mainMod, 8, workspace, 8"
                        "$mainMod, 9, workspace, 9"
                        "$mainMod, 0, workspace, 10"

                        "$mainMod SHIFT, 1, movetoworkspace, 1"
                        "$mainMod SHIFT, 2, movetoworkspace, 2"
                        "$mainMod SHIFT, 3, movetoworkspace, 3"
                        "$mainMod SHIFT, 4, movetoworkspace, 4"
                        "$mainMod SHIFT, 5, movetoworkspace, 5"
                        "$mainMod SHIFT, 6, movetoworkspace, 6"
                        "$mainMod SHIFT, 7, movetoworkspace, 7"
                        "$mainMod SHIFT, 8, movetoworkspace, 8"
                        "$mainMod SHIFT, 9, movetoworkspace, 9"
                        "$mainMod SHIFT, 0, movetoworkspace, 10"

                        "$altMod, Z, togglespecialworkspace, music"
                        "$altMod, X, togglespecialworkspace, discord"
                        "$altMod, C, togglespecialworkspace, terminal"

                        "$altMod SHIFT, Z, movetoworkspace, special:music"
                        "$altMod SHIFT, X, movetoworkspace, special:discord"
                        "$altMod SHIFT, C, movetoworkspace, special:terminal"

                        ", Caps_Lock, exec, qs ipc caps_osd toggle"
                    ];

                    bindr = [
                        "$mainMod, Super_L, exec, qs ipc call launcher toggle"
                    ];

                    binds = [
                        ", Super_L&Control_L&Alt_L&Shift_L&space, exec, qs ipc call emoji toggle"
                    ];

                    bindl = [
                        ", XF86AudioNext, exec, playerctl next"
                        ", XF86AudioPause, exec, playerctl play-pause"
                        ", XF86AudioPlay, exec, playerctl play-pause"
                        ", XF86AudioPrev, exec, playerctl previous"
                    ];

                    bindel = [
                        ", XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ && qs ipc call volume_osd toggle"
                        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
                        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
                        ", XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+ && qs ipc call brightness_osd show"
                        ", XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
                    ];

                    windowrule = [
                        "match:class .*, suppress_event maximize"
                        "match:class (geometrydash.exe), immediate yes"
                    ];

                    layerrule = [
                        "match:namespace rofi, dim_around on"
                    ];
                };
            };
        };
    };

    services = {
        hypridle.enable = false;
        mpd.enable = true;
        mpd-mpris.enable = true;
        cliphist.enable = true;
        swaync.enable = true;

        swaync = {
            settings = {
                ignore-gtk-theme = true;
                notification-inline-replies = true;
                notification-window-width = 400;
                notification-icon-size = 40;
            };
            style = lib.mkForce ''

                * {
                  font-family: "Inter";
                  font-size: 0.9rem;
                  text-shadow: none;
                  color: #cdd6f4;
                  box-shadow: none;
                  outline: none;
                  border: none;
                }
                .notification {
                  background: #181825;
                  padding: 0.75rem;
                  outline: none;
                  border: none;
                  color: #cdd6f4;
                  font-size: 0.4rem;
                }
                .notification:hover {
                  background: #1e1e2e;
                }
                .notification-content {
                  background-color: transparent;
                  padding: 0rem;
                  color: @secondary;
                }
                .image {
                  margin-right: 1.5rem;
                  border-radius: 0;
                }
            '';
        };

        mpd = {
            musicDirectory = "";
            extraConfig = ''
                music_directory "~/Music"
                state_file "~/.local/state/mpd/state"
                sticker_file "~/.local/share/mpd/sticker.sql"
                db_file "~/.local/share/mpd/database"

                port "6600"
                bind_to_address "::1"

                audio_output {
                        type            "pipewire"
                        name            "PipeWire Sound Server"
                }
            '';
        };
    };

    programs = {
        firefox.enable = true;
        zen-browser.enable = true;
        neovim.enable = true;
        nh.enable = true;
        starship.enable = true;
        hyprshot.enable = true;
        obs-studio.enable = true;
        zoxide.enable = true;
        rmpc.enable = true;
        kitty.enable = true;
        ghostty.enable = true;
        rofi.enable = true;
        fastfetch.enable = true;
        nixcord.enable = true;
        npm.enable = true;
        btop.enable = true;
        bash.enable = true;
        fish.enable = true;
        eza.enable = true;
        obsidian.enable = true;

        obsidian = {
            vaults = {
                Vault = {
                    enable = true;
                    target = "/home/tundra/Documents/Vault/";
                };
            };
        };

        eza = {
            icons = "auto";
            colors = "always";
            enableFishIntegration = true;

            theme = {
                colourful = true;
            };

            extraOptions = [
                "--oneline"
                "--long"
                "--group-directories-first"
                "--no-time"
                "--no-filesize"
                "--no-user"
                "--no-symlinks"
            ];
        };

        ghostty = {
            settings = {
                font-family = "JetBrainsMono Nerd Font";
                font-size = "11";
                adjust-cell-height = "10";
                adjust-icon-height = "3";

                theme = "catppuccin-mocha";

                background = "#181825";
                foreground = "#cdd6f4";

                selection-background = "#89b4fa";
                selection-foreground = "#181825";

                cursor-color = "#89b4fa";
                cursor-style = "underline";

                window-padding-x = "20";
                window-padding-y = "20";

                shell-integration-features = "sudo";

                notify-on-command-finish = "unfocused";
                notify-on-command-finish-action = "no-bell, notify";

                class = "Ghostty";
                window-decoration = "none";
            };

            themes = {
                catppuccin-mocha = {
                    background = "181825";
                    cursor-color = "89b4fa";
                    foreground = "cdd6f4";
                    palette = [
                        "0=#45475a"
                        "1=#f38ba8"
                        "2=#a6e3a1"
                        "3=#f9e2af"
                        "4=#89b4fa"
                        "5=#cba6f7"
                        "6=#94e2d5"
                        "7=#bac2de"
                        "8=#585b70"
                        "9=#f38ba8"
                        "10=#a6e3a1"
                        "11=#f9e2af"
                        "12=#89b4fa"
                        "13=#cba6f7"
                        "14=#94e2d5"
                        "15=#a6adc8"
                    ];
                    selection-background = "89b4fa";
                    selection-foreground = "181825";
                };
            };
        };

        nixcord = {
            equibop.enable = true;

            config = {
                enableReactDevtools = true;
                autoUpdate = true;
                frameless = true;
                plugins = {
                    SaveFavoriteGIFs.enable = true;
                    USRBG.enable = true;
                    betterGifPicker.enable = true;
                    fakeNitro.enable = true;
                    fakeProfileThemes.enable = true;
                    gifCollections.enable = true;
                    memberCount.enable = true;
                    mentionAvatars.enable = true;
                    messageLoggerEnhanced.enable = true;
                    plainFolderIcon.enable = true;
                    platformIndicators.enable = true;

                    fakeNitro = {
                        enableEmojiBypass = true;
                        enableStickerBypass = true;
                    };
                };
                enabledThemes = [
                    "midnight-catppuccin.css"
                    "quick-css.css"
                ];
            };
        };

        fastfetch = {
            settings = {
                logo = {
                    source = "/home/tundra/.config/nixos/nix.txt";
                    padding = {
                        right = 1;
                        top = 2;
                    };
                };
                display = {
                    separator = " ";
                };
                modules = [
                    {
                        type = "title";
                    }
                    "break"
                    {
                        type = "os";
                        key = "󱄅 ";
                        keyColor = "#89b4fa";
                        format = "{name} {##89b4fa}{#} {version}";
                    }
                    {
                        type = "kernel";
                        key = " ";
                        keyColor = "#89b4fa";
                        format = "{sysname} {##89b4fa}{#} {release} ";
                    }
                ];
            };
        };

        quickshell = {
            systemd.enable = true;
        };

        zen-browser = {
            policies = {
                DisablePocket = true;
                DisableTelemetry = true;
                DisableFirefoxStudies = true;
                OfferToSaveLogins = false;
            };
            profiles.default = {
                extensions = {
                    packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
                        ublock-origin
                        stylus
                        return-youtube-dislikes
                        sponsorblock
                        proton-pass
                    ];
                };

                sine = {
                    enable = true;
                };

                # mods = [
                #   "79dde383-4fe7-404a-a8e6-9be440022542" # Tidy Popup
                # ];

                settings = {
                    "devtools.chrome.enabled" = true;
                    "devtools.debugger.remote-enabled" = true;
                    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
                };

                userChrome = ''
                    /* Catppuccin Mocha Blue userChrome.css*/

                    :root {
                      --zen-colors-primary: #181825 !important;
                      --zen-primary-color: #89b4fa !important;
                      --zen-colors-secondary: #313244 !important;
                      --zen-colors-tertiary: #181825 !important;
                      --zen-colors-border: #89b4fa !important;
                      --toolbarbutton-icon-fill: #89b4fa !important;
                      --lwt-text-color: #cdd6f4 !important;
                      --toolbar-field-color: #cdd6f4 !important;
                      --tab-selected-textcolor: rgb(171, 197, 247) !important;
                      --toolbar-field-focus-color: #cdd6f4 !important;
                      --toolbar-color: #cdd6f4 !important;
                      --newtab-text-primary-color: #cdd6f4 !important;
                      --arrowpanel-color: #cdd6f4 !important;
                      --arrowpanel-background: #1e1e2e !important;
                      --sidebar-text-color: #cdd6f4 !important;
                      --lwt-sidebar-text-color: #cdd6f4 !important;
                      --lwt-sidebar-background-color: #11111b !important;
                      --toolbar-bgcolor: #181825 !important;
                      --newtab-background-color: #1e1e2e !important;
                      --zen-themed-toolbar-bg: #181825 !important;
                      --zen-main-browser-background: #181825 !important;
                      --toolbox-bgcolor-inactive: #181825 !important;
                    }

                    #permissions-granted-icon {
                      color: #181825 !important;
                    }

                    .sidebar-placesTree {
                      background-color: #1e1e2e !important;
                    }

                    #zen-workspaces-button {
                      background-color: #1e1e2e !important;
                    }

                    #TabsToolbar {
                      background-color: #181825 !important;
                    }

                    .urlbar-background {
                      background-color: #1e1e2e !important;
                    }

                    .content-shortcuts {
                      background-color: #1e1e2e !important;
                      border-color: #89b4fa !important;
                    }

                    .urlbarView-url {
                      color: #89b4fa !important;
                    }

                    #zenEditBookmarkPanelFaviconContainer {
                      background: #11111b !important;
                    }

                    #zen-media-controls-toolbar {
                      & #zen-media-progress-bar {
                        &::-moz-range-track {
                          background: #313244 !important;
                        }
                      }
                    }

                    toolbar .toolbarbutton-1 {
                      &:not([disabled]) {

                        &:is([open], [checked])> :is(.toolbarbutton-icon,
                          .toolbarbutton-text,
                          .toolbarbutton-badge-stack) {
                          fill: #11111b;
                        }
                      }
                    }

                    .identity-color-blue {
                      --identity-tab-color: #89b4fa !important;
                      --identity-icon-color: #89b4fa !important;
                    }

                    .identity-color-turquoise {
                      --identity-tab-color: #94e2d5 !important;
                      --identity-icon-color: #94e2d5 !important;
                    }

                    .identity-color-green {
                      --identity-tab-color: #a6e3a1 !important;
                      --identity-icon-color: #a6e3a1 !important;
                    }

                    .identity-color-yellow {
                      --identity-tab-color: #f9e2af !important;
                      --identity-icon-color: #f9e2af !important;
                    }

                    .identity-color-orange {
                      --identity-tab-color: #fab387 !important;
                      --identity-icon-color: #fab387 !important;
                    }

                    .identity-color-red {
                      --identity-tab-color: #f38ba8 !important;
                      --identity-icon-color: #f38ba8 !important;
                    }

                    .identity-color-pink {
                      --identity-tab-color: #f5c2e7 !important;
                      --identity-icon-color: #f5c2e7 !important;
                    }

                    .identity-color-purple {
                      --identity-tab-color: #cba6f7 !important;
                      --identity-icon-color: #cba6f7 !important;
                    }

                    hbox#titlebar {
                      background-color: #181825 !important;
                    }

                    #zen-appcontent-navbar-container {
                      background-color: #181825 !important;
                    }

                    .tab-reset-pin-button::after,
                    .urlbarView-title-separator,
                    .urlbarView-url,
                    .urlbarView-action,
                    menuseparator {
                      display: none !important;
                    }

                    .tab-reset-pin-button {
                    	padding-right: 3px !important;
                    }

                    .toolbarbutton-1:not(#tabs-newtab-button) {
                      --toolbarbutton-icon-fill: #cdd6f4 !important;
                    }

                    #tabbrowser-tabs .tabbrowser-tab[selected] .tab-background {
                      background: #89b4fa !important;
                    }

                    #tabbrowser-tabs .tabbrowser-tab[selected] .tab-content {
                      color: #181825 !important;
                      font-weight: 600
                    }

                    #tabbrowser-tabs .tabbrowser-tab .tab-icon-image {
                    	fill: #cdd6f4 !important;
                    	fill-opacity: 1 !important;
                    }

                    #tabbrowser-tabs .tabbrowser-tab[selected] .tab-icon-image {
                    	fill: #181825 !important;
                    	fill-opacity: 1 !important;
                    }

                    #tabbrowser-tabs .tabbrowser-tab .tab-content {
                      font-size: 12px !important;
                      font-weight: 400;
                      color: #cdd6f4 !important;
                    }

                    #tabbrowser-tabs .tabbrowser-tab {
                      margin-inline: 6px !important;
                    }

                    .urlbarView-row {
                      margin-inline: 8px;
                    }

                    .urlbarView-row[selected] {
                      background: #89b4fa !important;
                      border-radius: 0.75rem !important;

                      .urlbarView-title,
                      .urlbarView-switchToTab {
                        color: #181825 !important;
                      }
                    }

                    .urlbarView-title {
                      margin-right: 0.5rem
                    }

                    #urlbar-label-box {
                      background: #89b4fa !important;

                      label {
                        color: #181825 !important;
                      }
                    }

                    #urlbar[open]>.urlbarView>.urlbarView-body-outer>div {
                      border: none !important;
                    }

                    .urlbar-background {
                      outline: none !important;
                    }

                    .zen-current-workspace-indicator-name {
                      color: #7f849c
                    }

                    :host(:is(.anonymous-content-host, notification-message)),
                    :root {
                      --input-bgcolor: #1e1e2e !important;
                      --zen-input-border-color: transparent !important;
                    }

                    #statuspanel {
                      margin: 6px !important;
                    }

                    #statuspanel-label {
                      border-radius: 10000px !important;
                      padding: 4px 10px !important;
                      background: var(--zen-colors-tertiary) !important;
                      color: #cdd6f4 !important;
                    }

                    menupopup {
                      --panel-border-radius: 1rem !important;
                    }

                    menuitem {
                      color: #cdd6f4;
                    }

                    menuitem:hover {
                      background: #89b4fa !important;
                      color: #181825 !important;
                    }

                    #zen-browser-background {
                      --zen-main-browser-background: #181825 !important;
                    }

                    #tabbrowser-tabbox {
                      --zen-split-row-gap: 0 !important;
                      --zen-split-column-gap: 0 !important;
                      padding: 0 !important;
                    }


                    :root {
                    	--better-findbar-transform-translateY: 150px;
                    	--better-findbar-transform-translateX: -50%;
                    	--better-findbar-position-top: auto;
                    	--better-findbar-position-bottom: 15px;
                    	--better-findbar-position-left: 50%;
                    	--better-findbar-position-right: auto;
                    	--better-findbar-background-color: var(--zen-colors-primary);
                    	--better-findbar-text-color: var(--toolbar-color);
                    	--better-findbar-box-shadow: 0 5px 10px #00000080;
                    }

                    /* Custom background */
                    @media (-moz-bool-pref: "theme-better_find_bar-enable_custom_background") {
                    	:root {
                    		--better-findbar-background-color: var(--theme-better_find_bar-custom_background);
                    	}
                    }

                    /* Custom text color */
                    @media (-moz-bool-pref: "theme-better_find_bar-enable_custom_text_color") {
                    	:root {
                    		--better-findbar-text-color: var(--theme-better_find_bar-custom_text_color);
                    	}
                    }

                    /* Custom box shadow */
                    @media (-moz-bool-pref: "theme-better_find_bar-enable_custom_box_shadow") {
                    	:root {
                    		--better-findbar-box-shadow: var(--theme-better_find_bar-custom_box_shadow);
                    	}
                    }

                    findbar {
                    	display: flex !important;

                    	border-radius: var(--zen-border-radius) !important;
                    	margin: 0px !important;

                    	width: 90% !important;
                    	max-width: calc(var(--theme-better_find_bar-textbox_width) * 1px);

                    	height: auto !important;

                    	position: absolute !important;
                    	top: var(--better-findbar-position-top);
                    	bottom: var(--better-findbar-position-bottom);
                    	left: var(--better-findbar-position-left);
                    	right: var(--better-findbar-position-right);
                    	transform: translateX(var(--better-findbar-transform-translateX)) translateY(0);

                    	overflow: unset !important;
                    	box-shadow: var(--better-findbar-box-shadow);

                    	background: var(--better-findbar-background-color) !important;
                    	color: var(--better-findbar-text-color) !important;

                    	transition: transform 0.35s ease !important;

                    	visibility: visible !important;
                    	opacity: 1 !important;

                    	& .findbar-container {
                    		flex-wrap: wrap;
                    		overflow-x: auto !important;
                    		height: auto !important;

                    		row-gap: 10px;

                    		& > :first-child {
                    			width: 100% !important;
                    		}

                    		& .findbar-textbox {
                    			flex-grow: 1;
                    			background: var(--better-findbar-background-color) !important;
                    			color: var(--better-findbar-text-color) !important;


                    			&[status="notfound"] {
                    				background-color: color-mix(
                    					in srgb,
                    					var(--better-findbar-background-color),
                    					#e80538 50%
                    				) !important;
                    				color: inherit;
                    			}
                    		}

                    		& .findbar-textbox:focus {
                    			outline: 1px solid
                    				color-mix(
                    					in hsl,
                    					var(--better-findbar-background-color),
                    					var(--better-findbar-text-color) 75%
                    				) !important;
                    			outline-offset: -1px !important;
                    		}
                    	}

                    	&[hidden] {
                    		transform: translateX(var(--better-findbar-transform-translateX)) translateY(var(--better-findbar-transform-translateY));
                    	}

                    	@starting-style {
                    		transform: translateX(var(--better-findbar-transform-translateX)) translateY(var(--better-findbar-transform-translateY));
                    	}
                    }

                    /* Disable animations */
                    @media (-moz-bool-pref: "theme.better_find_bar.instant_animations") {
                    	findbar, findbar .findbar-container {
                    		transition: initial !important;
                    	}
                    }

                    /* Horizontal Position */
                    body:has(
                    		#theme-Better-Find-Bar[theme-better_find_bar-horizontal_position="left"]
                    	) {
                    	--better-findbar-transform-translateX: 0%;
                    	--better-findbar-position-left: 15px;
                    	--better-findbar-position-right: auto;
                    }

                    body:has(
                    		#theme-Better-Find-Bar[theme-better_find_bar-horizontal_position="right"]
                    	) {
                    	--better-findbar-transform-translateX: 0%;
                    	--better-findbar-position-left: auto;
                    	--better-findbar-position-right: 15px;
                    }

                    /* Vertical Position */
                    body:has(
                    		#theme-Better-Find-Bar[theme-better_find_bar-vertical_position="top"]
                    	) {
                    	--better-findbar-transform-translateY: -150px;
                    	--better-findbar-position-bottom: auto;
                    	--better-findbar-position-top: 15px;
                    }


                    /* Background blur */
                    @media (-moz-bool-pref: "theme.better_find_bar.transparent_background") {
                    	findbar,
                    	findbar .findbar-textbox:not([status="notfound"]) {
                    		backdrop-filter: blur(8px);

                    		background: color-mix(in hsl, var(--better-findbar-background-color), transparent 10%) !important;
                    	}
                    }

                    /* Hide highlight checkbox */
                    body:has(
                    		#theme-Better-Find-Bar[theme-better_find_bar-hide_highlight="hide_immediately"]
                    	) {
                    	findbar .findbar-highlight {
                    		display: none !important;
                    	}
                    }

                    body:has(
                    		#theme-Better-Find-Bar[theme-better_find_bar-hide_highlight="hide_on_disable"]
                    	) {
                    	findbar checkbox.findbar-highlight:not([checked]) {
                    		display: none !important;
                    	}
                    }

                    /* Hide match case checkbox */
                    body:has(
                    		#theme-Better-Find-Bar[theme-better_find_bar-hide_match_case="hide_immediately"]
                    	) {
                    	findbar .findbar-case-sensitive {
                    		display: none !important;
                    	}
                    }

                    body:has(
                    		#theme-Better-Find-Bar[theme-better_find_bar-hide_match_case="hide_on_disable"]
                    	) {
                    	findbar checkbox.findbar-case-sensitive:not([checked]) {
                    		display: none !important;
                    	}
                    }

                    /* Hide match diacritics checkbox */
                    body:has(
                    		#theme-Better-Find-Bar[theme-better_find_bar-hide_match_diacritics="hide_immediately"]
                    	) {
                    	findbar .findbar-match-diacritics {
                    		display: none !important;
                    	}
                    }

                    body:has(
                    		#theme-Better-Find-Bar[theme-better_find_bar-hide_match_diacritics="hide_on_disable"]
                    	) {
                    	findbar checkbox.findbar-match-diacritics:not([checked]) {
                    		display: none !important;
                    	}
                    }

                    /* Hide whole words checkbox */
                    body:has(
                    		#theme-Better-Find-Bar[theme-better_find_bar-hide_whole_words="hide_immediately"]
                    	) {
                    	findbar .findbar-entire-word {
                    		display: none !important;
                    	}
                    }

                    body:has(
                    		#theme-Better-Find-Bar[theme-better_find_bar-hide_whole_words="hide_on_disable"]
                    	) {
                    	findbar .findbar-entire-word:not([checked]) {
                    		display: none !important;
                    	}
                    }

                    .findbar-find-previous, .findbar-find-next {
                      fill: #cdd6f4 !important;
                    }

                    /* findbar .findbar-find-status {
                    	display: none !important;
                    }

                    findbar .findbar-label.found-matches {
                    	display: none !important;
                    } */


                    .tab-group-container.tab-group-container.tab-group-container {
                        margin-left: 18px !important;
                    }

                    .tab-group-label.tab-group-label.tab-group-label.tab-group-label {
                        color: var(--tab-group-color) !important;
                        font-size: 13px !important;
                    }

                '';
            };
        };

        # kitty = {
        #   font = {
        #     name = "AdwaitaMono Nerd Font";
        #     size = 11;
        #   };
        #   settings = {
        #     background = "#181825";
        #     foreground = "#cdd6f4";
        #
        #     selection_foreground = "#181825";
        #     selection_background = "#89b4fa";
        #
        #     cursor = "#89b4fa";
        #     cursor_text_color = "#181825";
        #     cursor_shape = "underline";
        #
        #     url_color = "#89b4fa";
        #     url_shape = "curly";
        #
        #     window_margin_width = "12";
        #
        #     color_0 = "#45475a";
        #     color_8 = "#585b70";
        #
        #     color_1 = "#a6e3a1";
        #     color_9 = "#a6e3a1";
        #
        #     color_2 = "#f38ba8";
        #     color_10 = "#f38ba8";
        #
        #     color_3 = "#f9e2af";
        #     color_11 = "#f9e2af";
        #
        #     color_4 = "#89b4fa";
        #     color_12 = "#89b4fa";
        #
        #     color_5 = "#cba6f7";
        #     color_13 = "#cba6f7";
        #
        #     color_6 = "#94e2d5";
        #     color_14 = "#94e2d5";
        #
        #     color_7 = "#bac2de";
        #     color_15 = "#a6adc8";
        #   };
        #   shellIntegration.enableFishIntegration = true;
        # };

        zoxide = {
            enableFishIntegration = true;

            options = [
                "--cmd cd"
            ];
        };

        starship = {
            enableTransience = true;
            enableFishIntegration = true;

            settings = {
                format = lib.concatStrings [
                    "$os"
                    "$username"
                    "$hostname"
                    "$directory"
                    "$character"
                ];

                os = {
                    disabled = false;
                    style = "bg:#89b4fa fg:#313244";
                    format = "[](fg:#89b4fa)[$symbol]($style)";
                    symbols = {NixOS = " ";};
                };

                username = {
                    show_always = true;
                    style_user = "bg:#89b4fa fg:#313244";
                    format = "[$user@]($style)";
                };

                hostname = {
                    ssh_only = false;
                    style = "bg:#89b4fa fg:#313244";
                    format = "[$hostname]($style)[](fg:#89b4fa bg:#313244)";
                };

                directory = {
                    style = "bg:#313244 fg:#89b4fa";
                    format = "[](fg:#313244 bg:#313244)[󰉋 $path]($style)[](fg:#313244)";
                };

                character = {
                    success_symbol = "[ ](fg:blue)";
                    error_symbol = "[ ](fg:red)";
                };
            };
        };

        nvf = {
            enable = true;

            settings.vim = {
                undoFile.enable = true;
                autopairs.nvim-autopairs.enable = true;
                telescope.enable = true;
                lineNumberMode = "number";

                luaConfigPre = ''
                    vim.o.autowriteall = true

                    vim.api.nvim_create_autocmd({ 'InsertLeavePre', 'TextChanged', 'TextChangedP' }, {
                        pattern = '*', callback = function()
                            vim.cmd('silent! write')
                        end
                    })
                '';

                options = {
                    tabstop = 4;
                    shiftwidth = 4;
                    tm = 300;
                    cursorline = true;
                    cursorlineopt = "number";
                };

                globals = {
                    mapleader = " ";
                    maplocalleader = " ";
                };

                keymaps = [
                    {
                        key = "<leader>w";
                        mode = "n";
                        action = ":w<cr>";
                    }

                    {
                        key = "<C-a>";
                        mode = "n";
                        action = "gg<S-v>G";
                    }

                    {
                        key = "C-s";
                        mode = "n";
                        action = ":w<cr>";
                    }

                    {
                        key = ">";
                        mode = "v";
                        action = ">gv";
                    }

                    {
                        key = "<";
                        mode = "v";
                        action = "<gv";
                    }
                ];

                clipboard = {
                    enable = true;

                    providers.wl-copy.enable = true;
                    registers = "unnamedplus";
                };

                treesitter = {
                    enable = true;
                    autotagHtml = true;
                    indent.enable = false;
                };

                utility = {
                    icon-picker.enable = true;

                    images = {
                        image-nvim = {
                            enable = true;
                            setupOpts.backend = "kitty";
                        };
                    };
                };

                theme = {
                    enable = true;
                    name = "catppuccin";
                    style = "mocha";
                    transparent = true;

                    extraConfig = ''
                        custom_highlights = function(colors)
                            return {
                                LineNr = { fg = colors.flamingo }
                            }
                        end
                    '';
                };

                visuals = {
                    nvim-web-devicons.enable = true;
                    tiny-devicons-auto-colors.enable = true;
                };

                ui = {
                    noice.enable = true;
                    nvim-highlight-colors = {
                        enable = true;

                        setupOpts = {
                            render = "virtual";
                            virtual_symbol_position = "eol";
                        };
                    };
                };

                autocomplete = {
                    blink-cmp = {
                        enable = true;

                        mappings = {
                            next = "<Tab>";
                            previous = "<S-Tab>";
                        };

                        setupOpts = {
                            completion.menu = {
                                border = "rounded";
                            };
                        };
                    };
                };

                lsp = {
                    enable = true;
                    formatOnSave = true;

                    lspconfig = {
                        enable = true;
                    };
                };

                diagnostics = {
                    enable = true;

                    config = {
                        signs = {
                            text = lib.generators.mkLuaInline ''
                                {
                                  [vim.diagnostic.severity.ERROR] = "󰅙 ",
                                  [vim.diagnostic.severity.WARN] = " ",
                                  [vim.diagnostic.severity.INFO] = "󰋼 ";
                                  [vim.diagnostic.severity.HINT] = "󰌵 "
                                }
                            '';
                        };

                        virtual_text = false;
                        virtual_lines = lib.generators.mkLuaInline ''
                            {
                              current_line = true
                            }
                        '';
                        update_in_insert = true;
                        underline = true;
                    };
                };

                languages = {
                    nix.enable = true;
                    qml.enable = true;
                    html.enable = true;
                    css.enable = true;
                    ts.enable = true;
                    python.enable = true;

                    html = {
                        extraDiagnostics.enable = true;
                    };

                    qml = {
                        format.enable = true;
                        lsp.enable = true;
                        treesitter.enable = true;
                    };

                    python = {
                        extraDiagnostics.enable = true;

                        format.enable = true;
                        lsp.enable = true;
                        treesitter.enable = true;
                    };

                    nix = {
                        extraDiagnostics.enable = true;

                        format.enable = true;
                        lsp.enable = true;
                        treesitter.enable = true;

                        lsp.servers = ["nil"];
                    };
                };

                statusline = {
                    lualine = {
                        enable = true;

                        activeSection = {
                            a = [
                                ''
                                    {
                                        "mode",
                                        icons_enabled = true,
                                        separator = {
                                            left = "",
                                            right = "",
                                        },
                                    }
                                ''
                            ];

                            b = [
                                ''
                                    {
                                      "filename",

                                      icon = "",
                                      colored = true,
                                      symbols = {
                                        modified = "󰏫",
                                        readonly = "",
                                        unnamed = "",
                                        newfile = "",
                                      },
                                      separator = {right = ''}
                                    }
                                ''
                            ];
                            x = [
                                ''
                                    {
                                      "diagnostics",
                                      sources = {'nvim_lsp', 'nvim_diagnostic', 'nvim_diagnostic', 'vim_lsp', 'coc'},
                                      symbols = {error = '󰅙  ', warn = '  ', info = '󰋼 ', hint = '󰌵 '},
                                      colored = true,
                                      update_in_insert = false,
                                      always_visible = false,
                                      diagnostics_color = {
                                        color_error = { fg = 'red' },
                                        color_warn = { fg = 'yellow' },
                                        color_info = { fg = 'cyan' },
                                      },
                                    }
                                ''
                            ];
                            y = [
                                ''
                                    {
                                      "filetype",
                                      icon = { align = 'right' },
                                      icon_only = true,
                                      colored = true,
                                      separator = { left = "" }
                                    }
                                ''
                            ];
                            z = [
                                ''
                                    {
                                      "location",

                                      separator = {
                                        left = "",
                                        right = "",
                                      },
                                    }
                                ''
                            ];
                        };
                    };
                };
            };
        };

        nh = {
            clean.enable = true;
            clean.extraArgs = "--keep-since 4d --keep 3";
            flake = "/home/tundra/config/";
        };

        yazi = {
            enable = true;
            enableFishIntegration = true;
        };
    };
}
