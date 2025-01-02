{ config, lib, pkgs, ... }: {

  # OPTIONS
  options = {
    modules.gnome = {
      enable = lib.mkEnableOption "";
      disableCoreApps = lib.mkEnableOption "";
    };
  };
  
  # CONFIG
  config = lib.mkIf config.modules.gnome.enable {
    # Enable GNOME and GDM
    services.xserver = {
      enable = true;
      displayManager.gdm.enable = true;
      displayManager.gdm.wayland = true;
      desktopManager.gnome.enable = true;
    };

    # Enable XDG desktop portal
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gnome ];
    };

  # Disable GNOME apps
  } // lib.optionalAttrs config.modules.gnome.disableCoreApps {
    services = {
      gnome = {
        core-utilities.enable = false;
        gnome-initial-setup.enable = false;
      };
    };

    environment.gnome.excludePackages = (with pkgs.gnome; [
      gnome-tour
      gnome-shell-extensions
    ]);
  };

}
