{ config, lib, pkgs, ... }: {

  # OPTIONS
  options.modules.greetd = {
    enable = lib.mkEnableOption "";
    sessions = lib.mkOption {
      type = lib.types.attrsOf (lib.types.submodule {
        options = {
          command = lib.mkOption {
            type = lib.types.str;
            description = "Command to start the session";
          };
          tty = lib.mkOption {
            type = lib.types.int;
            description = "TTY number to run this session on";
          };
        };
      });
      default = {};
    };
  };

  # CONFIG
  config = lib.mkIf config.modules.greetd.enable {
    # Configure greetd for each TTY
    services.greetd = {
      enable = true;
      vt = null; # Disable default VT assignment
    };

    # Configure separate getty+greetd instances for each session
    systemd.services = lib.mapAttrs' (name: session: lib.nameValuePair
      "greetd-${name}" {
        description = "Greeter daemon on tty${toString session.tty}";
        after = [ "systemd-user-sessions.service" "plymouth-quit-wait.service" "getty@tty${toString session.tty}.service" ];
        wants = [ "getty@tty${toString session.tty}.service" ];
        conflicts = [ "getty@tty${toString session.tty}.service" ];
        wantedBy = [ "multi-user.target" ];

        serviceConfig = {
          Type = "idle";
          ExecStart = "${pkgs.greetd}/bin/greetd --config /etc/greetd/config-${name}.toml";
          StandardInput = "tty";
          StandardOutput = "journal";
          StandardError = "journal";
          TTYPath = "/dev/tty${toString session.tty}";
          TTYReset = true;
          TTYVHangup = true;
          TTYVTDisallocate = true;
        };
      }
    ) config.modules.greetd.sessions;

    # Generate config files for each session
    environment.etc = lib.mapAttrs' (name: session: lib.nameValuePair
      "greetd/config-${name}.toml" {
        text = ''
          [terminal]
          vt = ${toString session.tty}

          [default_session]
          command = "${session.command}"
          user = "user"
        '';
      }
    ) config.modules.greetd.sessions;

}
