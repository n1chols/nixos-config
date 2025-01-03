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
          wantedBy = [ "multi-user.target" ];
          serviceConfig = {
            Type = "simple";
            User = "user";
            TTYPath = "/dev/tty${toString (index + 1)}";
            ExecStart = "${pkgs.bash}/bin/bash -l -c '${session}'";
            Restart = "always";
          };
        };
      }) config.modules.multistart.sessions
    );
  };

}
