{ config, lib, pkgs, ... }: {

  # OPTIONS
  options = {
    modules.gnome = {
      enable = lib.mkEnableOption "";
      disableCoreApps = lib.mkEnableOption "";
    };
  };
  
  # CONFIG
  config = lib.mkMerge [
    # Enable GNOME, GDM, XDG desktop portal
    (lib.mkIf config.modules.gnome.enable {
      services.xserver = {
        enable = true;
        displayManager.gdm.enable = true;
        displayManager.gdm.wayland = true;
        desktopManager.gnome.enable = true;
      };

      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [ xdg-desktop-portal-gnome ];
      };
    })

    # Disable GNOME Apps
    (lib.mkIf config.modules.gnome.disableCoreApps {
      services = {
        gnome = {
          core-utilities.enable = false;
          gnome-initial-setup.enable = false;
        };
      };

      environment.gnome.excludePackages = (with pkgs; [
        gnome-tour
        gnome-shell-extensions
      ]);
    })
  ];

}
