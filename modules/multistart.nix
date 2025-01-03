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
        after = [ "systemd-user-sessions.service" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "simple";
          User = "YOUR_USERNAME";  # Replace with your username
          PAMName = "login";
          TTYPath = "/dev/tty1";
          StandardInput = "tty";
          StandardOutput = "tty";
          StandardError = "journal";
          UtmpIdentifier = "tty1";
          UtmpMode = "user";
          ExecStart = "${pkgs.runtimeShell} -c 'dbus-run-session env XDG_SESSION_TYPE=wayland gnome-session'";
        };
        environment = {
          XDG_SESSION_TYPE = "wayland";
          DISPLAY = ":0";
        };
      };

      steam-gamescope-tty2 = {
        description = "Steam Big Picture (Gamescope) on TTY2";
        after = [ "systemd-user-sessions.service" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "simple";
          User = "YOUR_USERNAME";  # Replace with your username
          PAMName = "login";
          TTYPath = "/dev/tty2";
          StandardInput = "tty";
          StandardOutput = "tty";
          StandardError = "journal";
          UtmpIdentifier = "tty2";
          UtmpMode = "user";
          ExecStart = "${pkgs.runtimeShell} -c '${pkgs.gamescope}/bin/gamescope -- ${pkgs.steam}/bin/steam -tenfoot -pipewire-dmabuf'";
        };
        environment = {
          DISPLAY = ":1";
        };
      };

      kodi-tty3 = {
        description = "Kodi on TTY3";
        after = [ "systemd-user-sessions.service" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "simple";
          User = "YOUR_USERNAME";  # Replace with your username
          PAMName = "login";
          TTYPath = "/dev/tty3";
          StandardInput = "tty";
          StandardOutput = "tty";
          StandardError = "journal";
          UtmpIdentifier = "tty3";
          UtmpMode = "user";
          ExecStart = "${pkgs.runtimeShell} -c 'env LIRC_SOCKET_PATH=/run/lirc/lircd ${pkgs.kodi}/bin/kodi --standalone'";
        };
        environment = {
          DISPLAY = ":2";
        };
      };
    };


    # Enable required services
    services.xserver.enable = true;
    services.dbus.enable = true;
    hservices.lirc.enable = true;
  };

}
