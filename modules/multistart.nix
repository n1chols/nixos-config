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

    # Add user to necessary groups
    users.users.user.extraGroups = [ "video" "render" "input" ];

    environment.etc = lib.listToAttrs (lib.imap1 (index: name: {
      name = "greetd/${name}-config.toml";
      value = {
        text = ''
          [terminal]
          vt = ${toString (index + 1)}

          [default_session]
          command = "${lib.getAttr name config.modules.greetd.sessions}"
          user = "user"
          
          [initial_session_switcher]
          enabled = false
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
          RestartSec = "1s";
          StandardOutput = "journal";
          StandardError = "journal";
          # Give access to DRM
          SupplementaryGroups = [ "video" "render" "input" ];
          Environment = [
            "WLR_RENDERER=vulkan"
            "XDG_SESSION_TYPE=wayland"
            "WAYLAND_DISPLAY=wayland-1"
          ];
        };
      };
    }) (lib.tail (lib.attrNames config.modules.greetd.sessions)));
  };
}
