{ config, lib, pkgs, ... }: {

  # OPTIONS
  options.modules.multistart = {
    enable = lib.mkEnableOption "";
    sessions = lib.mkOption {
      type = lib.types.listOf lib.types.str;
    };
  };

  # CONFIG
  config = lib.mkIf config.modules.multistart.enable {

    services.greetd = {
      enable = true;
      vt = 1;  # Start on tty1
      settings = {
        default_session = {
          command = "${pkgs.gamescope}/bin/gamescope -- ${pkgs.steam}/bin/steam -tenfoot -pipewire-dmabuf";#"dbus-run-session env XDG_SESSION_TYPE=wayland gnome-session";
          user = "user";
        };
      };
    };
  
    # Additional greetd instances for Steam and Kodi
    systemd.services."greetd-tty2" = {
      description = "Steam Big Picture Mode on TTY 2";
      after = [ "systemd-user-sessions.service" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "simple";
        ExecStart = ''
          ${pkgs.greetd.greetd}/bin/greetd \
            --config <(echo '{ "terminal": { "vt": 2 }, \
            "default_session": { \
              "command": "${pkgs.gamescope}/bin/gamescope -- ${pkgs.steam}/bin/steam -tenfoot -pipewire-dmabuf", \
              "user": "user" \
            } }')
        '';
        Restart = "always";
      };
    };

    systemd.services."greetd-tty3" = {
      description = "Kodi on TTY 3";
      after = [ "systemd-user-sessions.service" ];
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "simple";
        ExecStart = ''
          ${pkgs.greetd.greetd}/bin/greetd \
            --config <(echo '{ "terminal": { "vt": 3 }, \
            "default_session": { \
              "command": "${pkgs.kodi}/bin/kodi --standalone", \
              "user": "user" \
            } }')
        '';
        Restart = "always";
      };
    };

    # Enable autologin on TTYs 1-3
    services.getty.autologinUser = "user";

    # Enable required services
    services.xserver.enable = true;
    services.dbus.enable = true;
  };

}
