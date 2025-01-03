{ config, lib, pkgs, ... }: {

  # OPTIONS
  options.modules.greetd = {
    enable = lib.mkEnableOption "";
    defaultSession = lib.mkOption {
      type = lib.types.str;
    };
    otherSessions = lib.mkOption {
      type = lib.types.listOf lib.types.str;
    };
  };

  # CONFIG
  config = lib.mkIf config.modules.greetd.enable {
    # Enable autologin
    services.getty.autologinUser = "user";

    # Enable greetd
    #services.greetd = {
    #  enable = true;
    #  settings = {
    #    default_session = {
    #      command = config.modules.greetd.defaultSession;
    #      user = "user";
    #    };
    #  };
    #};

    systemd.user.services = {
      gamescope-steam = {
        description = "Steam in Gamescope";
        wantedBy = [ "default.target" ];
        after = [ "graphical-session-pre.target" ];
        serviceConfig = {
          Type = "simple";
          Environment = [
            "DISPLAY=:1"
            "XDG_SESSION_TYPE=x11"
          ];
          ExecStart = ''
            #${pkgs.xorg.xinit}/bin/xinit \
            ${pkgs.gamescope}/bin/gamescope -- \
            ${pkgs.steam}/bin/steam -tenfoot -pipewire-dmabuf \
            -- :1 vt2
          '';
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 30;
        };
      };

      kodi = {
        description = "Kodi Media Center";
        wantedBy = [ "default.target" ];
        after = [ "graphical-session-pre.target" ];
        serviceConfig = {
          Type = "simple";
          Environment = [
            "DISPLAY=:2"
            "XDG_SESSION_TYPE=x11"
          ];
          ExecStart = ''
            #${pkgs.xorg.xinit}/bin/xinit \
            ${pkgs.kodi}/bin/kodi --standalone \
            -- :2 vt3
          '';
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 30;
        };
      };
    };
    # Goofy-ah
    programs.xwayland.enable = true;

    services.xserver = {
      enable = true;
      displayManager = {
        gdm.enable = false;
        sessionCommands = ''
          export XDG_SESSION_TYPE=wayland
          export GDK_BACKEND=wayland
          export MOZ_ENABLE_WAYLAND=1
        '';
      };
    };

    programs.dconf.enable = true;

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      GDG_BACKEND = "wayland";
    };

    environment.systemPackages = with pkgs; [
      dbus
      gnome-session
      gnome-shell
      gnome-desktop
      adwaita-icon-theme
    ];
  };

}
