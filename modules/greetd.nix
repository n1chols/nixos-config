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
    services.greetd = {
      enable = true;
      vt = 1;
      settings = {
        default_session = {
          command = config.modules.greetd.defaultSession;
          user = "greeter";
        };
      };
    };

    # Automatically start sessions on TTY2 and TTY3
    systemd.services = lib.listToAttrs (lib.imap0 (index: session: {
      name = "autologin-tty${toString (index + 2)}";
      value = {
        description = "Automatic login on tty${toString (index + 2)}";
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "idle";
          ExecStart = session;
          TTYPath = "/dev/tty${toString (index + 2)}";
          TTYReset = true;
          TTYVTDisallocate = true;
        };
        after = [ "systemd-user-sessions.service" "plymouth-quit-wait.service" "getty@tty${toString (index + 2)}.service" ];
        conflicts = [ "getty@tty${toString (index + 2)}.service" ];
      };
    }) config.modules.greetd.otherSessions);

    # Default user for the auto-started sessions
    users.users.greeter = {
      isSystemUser = true;
      group = "greeter";
    };
    users.groups.greeter = {};
  };

}
