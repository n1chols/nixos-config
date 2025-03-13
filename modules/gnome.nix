{ config, lib, pkgs, ... }: {
  
  # Enable GDM and GNOME
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Enable XDG desktop portal
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gnome ];
  };

  # Disable GNOME core apps and setup
  services.gnome = {
    core-utilities.enable = false;
    gnome-initial-setup.enable = false;
  };

  # Disable the remaining apps
  environment.gnome.excludePackages = (with pkgs; [
    gnome-tour
    gnome-shell-extensions
  ]);

}
