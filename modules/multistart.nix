{ config, lib, pkgs, ... }: {

  # OPTIONS
  options.modules.multistart = {
    enable = lib.mkEnableOption "";
    sessions = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of commands to start in separate TTYs";
    };
  };

  # CONFIG
  config = lib.mkIf config.modules.multistart.enable {
    # Configure greetd for each TTY
    services.greetd = {
      enable = true;
      vt = null; # Disable default VT assignment
    };

    # Configure separate getty+greetd instances for each session
    systemd.services = lib.listToAttrs (lib.imap0 (index: command:
      lib.nameValuePair
        "greetd-session-${toString (index + 1)}" {
          description = "Greeter daemon on tty${toString (index + 1)}";
          after = [ "systemd-user-sessions.service" "plymouth-quit-wait.service" "getty@tty${toString (index + 1)}.service" ];
          wants = [ "getty@tty${toString (index + 1)}.service" ];
          conflicts = [ "getty@tty${toString (index + 1)}.service" ];
          wantedBy = [ "multi-user.target" ];

          serviceConfig = {
            Type = "idle";
            ExecStart = "${pkgs.greetd}/bin/greetd --config /etc/greetd/config-${toString (index + 1)}.toml";
            StandardInput = "tty";
            StandardOutput = "journal";
            StandardError = "journal";
            TTYPath = "/dev/tty${toString (index + 1)}";
            TTYReset = true;
            TTYVHangup = true;
            TTYVTDisallocate = true;
          };
        }
    ) config.modules.multistart.sessions);

    # Generate config files for each session
    environment.etc = lib.listToAttrs (lib.imap0 (index: command:
      lib.nameValuePair
        "greetd/config-${toString (index + 1)}.toml" {
          text = ''
            [terminal]
            vt = ${toString (index + 1)}

            [default_session]
            command = "${command}"
            user = "user"
          '';
        }
    ) config.modules.multistart.sessions);
  };

}
