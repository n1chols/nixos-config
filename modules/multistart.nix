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
    # Configure greetd base service
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = builtins.elemAt config.modules.multistart.sessions 0;
          user = "user";
        };
      };
    };

    # Configure separate getty+greetd instances for each session
    systemd.services = lib.listToAttrs (lib.imap0 (index: command:
      let
        tty = toString (index + 1);
      in lib.nameValuePair
        "greetd-session-${tty}" {
          description = "Greeter daemon on tty${tty}";
          after = [ "systemd-user-sessions.service" "plymouth-quit-wait.service" "getty@tty${tty}.service" ];
          wants = [ "getty@tty${tty}.service" ];
          conflicts = [ "getty@tty${toString (index + 1)}.service" ];
          wantedBy = [ "multi-user.target" ];

          serviceConfig = {
            Type = "idle";
            ExecStart = "${pkgs.greetd}/bin/greetd --config /etc/greetd/config-${tty}.toml";
            StandardInput = "tty";
            StandardOutput = "journal";
            StandardError = "journal";
            TTYPath = "/dev/tty${tty}";
            TTYReset = true;
            TTYVHangup = true;
            TTYVTDisallocate = true;
          };
        }
    ) config.modules.multistart.sessions);

    # Generate config files for each session
    environment.etc = lib.listToAttrs (lib.imap0 (index: command:
      let
        tty = toString (index + 1);
      in lib.nameValuePair
        "greetd/config-${tty}.toml" {
          text = ''
            [terminal]
            vt = ${tty}

            [default_session]
            command = "${command}"
            user = "user"
          '';
        }
    ) config.modules.multistart.sessions);
  };

}
