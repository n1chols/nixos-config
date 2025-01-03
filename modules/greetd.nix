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

    environment.etc = lib.mapAttrs' (name: command: lib.nameValuePair
      "greetd/${name}-config.toml"
      { text = ''
          [terminal]
          vt = ${toString (lib.findFirst (n: true) 1 (lib.flip lib.elemAt (lib.attrNames config.modules.greetd.sessions) (lib.findFirst (i: lib.elemAt (lib.attrNames config.modules.greetd.sessions) i == name) 0 (lib.range 0 (lib.length (lib.attrNames config.modules.greetd.sessions))))))}

          [default_session]
          command = "${command}"
          user = "user"
        '';
      }
    ) (lib.tail (lib.mapAttrs (name: value: value) config.modules.greetd.sessions));

    systemd.services = lib.mapAttrs' (name: command: lib.nameValuePair
      "greetd-${name}"
      {
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.greetd.greetd}/bin/greetd --config /etc/greetd/${name}-config.toml";
          Restart = "always";
        };
      }
    ) (lib.tail (lib.mapAttrs (name: value: value) config.modules.greetd.sessions));
  };

}
