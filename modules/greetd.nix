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

    environment.etc = lib.listToAttrs (lib.imap1 (index: name: {
      name = "greetd/${name}-config.toml";
      value = {
        text = ''
          [terminal]
          vt = ${toString index}

          [default_session]
          command = "dbus-run-session ${lib.getAttr name config.modules.greetd.sessions}"
          user = "user"

          [environment]
          XDG_SESSION_TYPE = "wayland"
          XDG_CURRENT_DESKTOP = "GNOME"
          WAYLAND_DISPLAY = "wayland-1"
          DISPLAY = ":1"
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
