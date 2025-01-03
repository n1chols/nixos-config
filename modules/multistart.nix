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

    systemd.services = {
      gnome-session-tty1 = {
        description = "GNOME Session on TTY1";
        after = [ "systemd-user-sessions.service" "network.target" "sound.target" ];
        requires = [ "systemd-logind.service" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "simple";
          User = "user";  # Replace with your username
          WorkingDirectory = "~";
          PAMName = "login";
          TTYPath = "/dev/tty1";
          StandardInput = "tty";
          StandardOutput = "tty";
          StandardError = "journal";
          UtmpIdentifier = "tty1";
          UtmpMode = "user";
          RuntimeDirectory = "gnome-session";
          RuntimeDirectoryMode = "0700";
          ExecStartPre = "${pkgs.coreutils}/bin/sleep 1";
          ExecStart = ''
            ${pkgs.bash}/bin/bash -l -c "dbus-run-session env XDG_SESSION_TYPE=wayland gnome-session"
          '';
        };
        environment = {
          XDG_SESSION_TYPE = "wayland";
          DISPLAY = ":0";
          HOME = "/home/user";  # Replace with your username
          USER = "user";  # Replace with your username
          SHELL = "/run/current-system/sw/bin/bash";
        };
      };

      steam-gamescope-tty2 = {
        description = "Steam Big Picture (Gamescope) on TTY2";
        after = [ "systemd-user-sessions.service" "network.target" "sound.target" ];
        requires = [ "systemd-logind.service" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "simple";
          User = "user";  # Replace with your username
          WorkingDirectory = "~";
          PAMName = "login";
          TTYPath = "/dev/tty2";
          StandardInput = "tty";
          StandardOutput = "tty";
          StandardError = "journal";
          UtmpIdentifier = "tty2";
          UtmpMode = "user";
          RuntimeDirectory = "steam";
          RuntimeDirectoryMode = "0700";
          ExecStartPre = "${pkgs.coreutils}/bin/sleep 1";
          ExecStart = ''
            ${pkgs.bash}/bin/bash -l -c "${pkgs.gamescope}/bin/gamescope -- ${pkgs.steam}/bin/steam -tenfoot -pipewire-dmabuf"
          '';
        };
        environment = {
          DISPLAY = ":1";
          HOME = "/home/user";
          USER = "user";
          SHELL = "/run/current-system/sw/bin/bash";
        };
      };

      kodi-tty3 = {
        description = "Kodi on TTY3";
        after = [ "systemd-user-sessions.service" "network.target" "sound.target" ];
        requires = [ "systemd-logind.service" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "simple";
          User = "user";  # Replace with your username
          WorkingDirectory = "~";
          PAMName = "login";
          TTYPath = "/dev/tty3";
          StandardInput = "tty";
          StandardOutput = "tty";
          StandardError = "journal";
          UtmpIdentifier = "tty3";
          UtmpMode = "user";
          RuntimeDirectory = "kodi";
          RuntimeDirectoryMode = "0700";
          ExecStartPre = "${pkgs.coreutils}/bin/sleep 1";
          ExecStart = ''
            ${pkgs.bash}/bin/bash -l -c "env LIRC_SOCKET_PATH=/run/lirc/lircd ${pkgs.kodi}/bin/kodi --standalone"
          '';
        };
        environment = {
          DISPLAY = ":2";
          HOME = "/home/user";  # Replace with your username
          USER = "user";  # Replace with your username
          SHELL = "/run/current-system/sw/bin/bash";
        };
      };
    };


    # Enable required services
    services.xserver.enable = true;
    services.dbus.enable = true;
  };

}
