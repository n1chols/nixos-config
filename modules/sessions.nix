{ config, lib, pkgs, ... }: {

  # OPTIONS
  options.modules.sessions = {
    enable = lib.mkEnableOption "";
    ttys = lib.mkOption {
      type = types.listOf str;
    };
  };

  # CONFIG
  config = lib.mkIf config.modules.sessions.enable {
    # Enable greetd and first session
    services.greetd = {
      enable = true;
      settings.default_session = {
        command = lib.head config.modules.sessions.ttys;
        user = "user";
      };
    };
    
    # Create config(s) for remaining session(s)
    environment.etc = lib.listToAttrs (lib.imap1 (i: cmd: {
      name = "greetd/session${toString i}-config.toml";
      value.text = ''
        [terminal]
        vt = ${toString (i + 1)}
        [default_session]
        command = "${cmd}"
        user = "user"
      '';
    }) (lib.tail config.modules.sessions.ttys));

    # Create start service(s) for remaining session(s)
    systemd.services = lib.listToAttrs (lib.imap1 (i: cmd: {
      name = "greetd-session${toString i}";
      value = {
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.greetd.greetd}/bin/greetd --config /etc/greetd/session${toString i}-config.toml";
          Restart = "always";
        };
      };
    }) (lib.tail config.modules.sessions.ttys));
  };

}
