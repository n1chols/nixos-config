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
          command = "XDG_SESSION_TYPE=wayland /usr/bin/env GNOME_SHELL_SESSION_MODE=ubuntu dbus-run-session /usr/bin/gnome-session --session=ubuntu";
          user = "user";
        };
      };
    };
  };

}
