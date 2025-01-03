{ config, lib, pkgs, ... }: {

  options = {
    modules.greetd = {
      enable = lib.mkEnableOption "";
      sessions = lib.mkOption {
        default = {};
        type = with lib.types; attrsOf str;
      };
    };
  };

  config = lib.mkIf config.modules.greetd.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = lib.head (lib.attrValues config.modules.greetd.sessions);
          user = "user";
        };
      };
    };

    environment.etc = lib.listToAttrs (map (name: {
      name = "greetd/${name}-config.toml";
      value = {
        text = ''
          [terminal]
          vt = ${toString (lib.findFirst (n: true) 1 (lib.flip lib.elemAt (lib.attrNames config.modules.greetd.sessions) (lib.findFirst (i: lib.elemAt (lib.attrNames config.modules.greetd.sessions) i == name) 0 (lib.range 0 (lib.length (lib.attrNames config.modules.greetd.sessions))))))}

          [default_session]
          command = "${lib.getAttr name config.modules.greetd.sessions}"
          user = "user"
        '';
      };
    }) (lib.tail (lib.attrNames config.modules.greetd.sessions)));

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
    }) (lib.tail (lib.attrNames config.modules.greetd.sessions)));
  };

}
