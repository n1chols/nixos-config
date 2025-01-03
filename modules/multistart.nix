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
    # We need logind for session management
    services.logind.enable = true;

    # Create systemd services for each session
    systemd.services = builtins.listToAttrs (
      lib.imap0 (idx: session: {
        name = "multistart-session-${toString idx}";
        value = {
          description = "Multistart Session ${toString idx}";
          
          after = [ "systemd-logind.service" ];
          requires = [ "systemd-logind.service" ];
          
          environment = {
            DISPLAY = ":${toString idx}";
            XAUTHORITY = "/run/user/1000/.Xauthority";
          };

          serviceConfig = {
            User = "user";
            PAMName = "login";
            TTYPath = "/dev/tty${toString (1 + idx)}";
            StandardInput = "tty";
            StandardOutput = "journal";
            StandardError = "journal";
            WorkingDirectory = "~";
            
            # Security settings
            NoNewPrivileges = true;
            PrivateTmp = true;
            RestrictNamespaces = true;
            
            ExecStart = "${pkgs.bash}/bin/bash -c '${session}'";
            Restart = "always";
          };

          wantedBy = [ "multi-user.target" ];
        };
      }) config.modules.multistart.sessions
    );

    # Configure logind to reserve our TTYs
    services.logind.extraConfig = ''
      NAutoVTs=${toString (1 + (builtins.length config.modules.multistart.sessions))}
    '';
  };

}
