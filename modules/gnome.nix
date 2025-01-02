{ config, lib, pkgs, ... }: {

  # OPTIONS
  options = {
    modules.gnome = {
      enable = lib.mkEnableOption "";
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
    services = {
      gnome.core-utilities.enable = false;
    };
  };

}
