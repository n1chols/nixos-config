{ config, lib, pkgs, ... }: {
  options = {
    modules.multistart = {
      enable = lib.mkEnableOption "";
      sessions = lib.mkOption {
        default = {};
        type = with lib.types; attrsOf str;
      };
    };
  };

  config = lib.mkIf config.modules.multistart.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = builtins.elemAt (lib.attrValues config.modules.multistart.sessions) 0;
          user = "user";
        };
      };
    };

    environment.etc = lib.listToAttrs (lib.imap1 (index: name: {
      name = "greetd/${name}-config.toml";
      value = {
        text = ''
          [terminal]
          vt = ${toString (index + 1)}

          [default_session]
          command = "${lib.getAttr name config.modules.multistart.sessions}"
          user = "user"
        '';
      };
    }) (lib.tail (lib.attrNames config.modules.multistart.sessions)));

    systemd.services = lib.listToAttrs (map (name: {
      name = "greetd-${name}";
      value = {
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.greetd.greetd}/bin/greetd --config /etc/greetd/${name}-config.toml";
          Restart = "always";
        };
      };
    }) (lib.tail (lib.attrNames config.modules.multistart.sessions)));
  };

}
