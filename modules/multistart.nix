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
      settings = {
        default_session = {
          command = "./etc/greetd/default-session";
          user = "user";
        };
      };
    };

    # Create the script that launches our sessions
    environment.etc."greetd/default-session".text = ''
      #!${pkgs.bash}/bin/bash
    
      case $(tty) in
        "/dev/tty1")
          exec dbus-run-session env XDG_SESSION_TYPE=wayland gnome-session
          ;;
        "/dev/tty2")
          exec ${pkgs.gamescope}/bin/gamescope -- ${pkgs.steam}/bin/steam -tenfoot -pipewire-dmabuf
          ;;
        "/dev/tty3")
          exec ${pkgs.kodi}/bin/kodi --standalone
          ;;
      esac
    '';

    # Make the script executable
    system.activationScripts.greetdScript = ''
      chmod +x /etc/greetd/default-session
    '';

    # Enable autologin on TTYs 1-3
    services.getty.autologinUser = "user";
    #services.getty.extraArgs = [ "--noclear" ];  # Prevent screen clearing
    services.getty.greetingLine = "";  # Remove login message

    # Enable TTYs 1-3
    services.getty.helpLine = "";
    services.getty.terminals = [ "tty1" "tty2" "tty3" ];

    # Enable required services
    services.xserver.enable = true;
    services.dbus.enable = true;
  };

}
