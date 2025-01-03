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
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = config.modules.greetd.defaultSession;
          user = "user";
        };
      };
    };

    # Goofy-ah
    programs.xwayland.enable = true;

    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };

    environment.systemPackages = with pkgs; [
      dbus
      gnome-session
      gnome-shell
    ];
  };

}
