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
    #services.xserver.displayManager.enabled = false;

    # Enable tty auto login
    services.getty.autologinUser = "user";

    # Create login service(s)
    systemd.user.services = lib.mapAttrs (name: service: {
      description = "Autologin ${name} service on ${service.tty}";
      after = [ "graphical-session-pre.target" ];
      wants = [ "graphical-session-pre.target" ];
      wantedBy = [ "default.target" ];
      
      environment = {
        XDG_SESSION_TYPE = "tty";
        DISPLAY = ":${builtins.substring 3 1 service.tty}";
      };

      serviceConfig = {
        Type = "simple";
        ExecStart = service.command;
        TTYPath = "/dev/${service.tty}";
        TTYReset = true;
        TTYVTDisallocate = true;
        StandardInput = "tty";
        StandardOutput = "journal";
        StandardError = "journal";
        PAMName = "login";
        WorkingDirectory = "~";
        Restart = "always";
      };
    }) config.modules.autotty.services;

    # Ensure systemd user services start on boot
    systemd.user.services = {
      systemd-tmpfiles-setup.enable = true;
      systemd-tmpfiles-setup-dev.enable = true;
    };
  };

}
