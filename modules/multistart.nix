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
    # Enable autologin
    services.getty.autologinUser = "user";

    # Create systemd services for each session
    systemd.services = builtins.listToAttrs (
      lib.imap0 (index: session: {
        name = "session-tty${toString (index + 1)}";
        value = {
          after = [ "getty@tty${toString (index + 1)}.service" ];
          wantedBy = [ "multi-user.target" ];
          environment = {
            XDG_SESSION_TYPE = "tty";
            XDG_RUNTIME_DIR = "/run/user/1000";
            DBUS_SESSION_BUS_ADDRESS = "unix:path=/run/user/1000/bus";
          };
          serviceConfig = {
            Type = "simple";
            User = "user";
            PAMName = "login";
            StandardInput = "tty";
            StandardOutput = "tty";
            TTYPath = "/dev/tty${toString (index + 1)}";
            TTYReset = true;
            TTYVHangup = true;
            TTYVTDisallocate = true;
            WorkingDirectory = "~";
            ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p /run/user/1000";
            ExecStart = "${pkgs.bash}/bin/bash -l -c '${session}'";
            Restart = "always";
          };
        };
      }) config.modules.multistart.sessions
    );
  };

}
