{ config, lib, pkgs, ... }: {

  options = {
    modules.autotty = {
      enable = lib.mkEnableOption "";
      services = lib.mkOption {
        default = {};
        type = with lib.types; attrsOf (submodule {
          options = {
            tty = lib.mkOption {
              type = str;
            };
            command = lib.mkOption {
              type = str;
            };
          };
        });
      };
    };
  };

  config = lib.mkIf config.modules.autotty.enable {
    # Disable display manager
    services.xserver.displayManager.enabled = false;

    # Enable tty auto login
    services.getty.autologinUser = "user";

    # Create login service(s)
    systemd.user.services = lib.mapAttrs (name: service: {
      wantedBy = [ "default.target" ];
      serviceConfig = {
        ExecStart = service.command;
        TTYPath = "/dev/${service.tty}";
      };
    }) config.modules.autotty.services;
  };

}
