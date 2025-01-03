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

    services.getty.autologinUser = "user";  # Replace with your username
  
    environment.etc."profile.d/auto-start-sessions.sh".text = ''
      case "$(tty)" in
        /dev/tty1)
          if [[ ! $DISPLAY ]]; then
            exec dbus-run-session env XDG_SESSION_TYPE=wayland gnome-session
          fi
          ;;
        /dev/tty2)
          if [[ ! $DISPLAY ]]; then
            exec ${pkgs.gamescope}/bin/gamescope -- ${pkgs.steam}/bin/steam -tenfoot -pipewire-dmabuf
          fi
          ;;
        /dev/tty3)
          if [[ ! $DISPLAY ]]; then
            exec ${pkgs.kodi}/bin/kodi --standalone
          fi
          ;;
      esac
    '';

    # Enable required services
    services.xserver.enable = true;
    services.dbus.enable = true;
  };

}
