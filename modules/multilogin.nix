{ config, lib, pkgs, ... }: {
  options = {
    modules.multilogin = {
      enable = lib.mkEnableOption "";
      sessions = lib.mkOption {
        type = with lib.types; listOf str;
      };
    };
  };

  config = lib.mkIf config.modules.multilogin.enable {
    services.greetd.enable = true;
    services.greetd.settings.default_session = {
      command = lib.head config.modules.multilogin.sessions;
      user = "user";
    };

    environment.etc = lib.listToAttrs (lib.imap1 (i: cmd: {
      name = "greetd/session${toString i}-config.toml";
      value.text = ''
        [terminal]
        vt = ${toString (i + 1)}
        [default_session]
        command = "${cmd}"
        user = "user"
      '';
    }) (lib.tail config.modules.multilogin.sessions));

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
    }) (lib.tail config.modules.multilogin.sessions));
  };

}
