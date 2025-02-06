{ config, lib, pkgs, ... }: {
  
  # Enable KDE Plasma
  services.desktopManager.plasma6.enable = true;

  # Disable extra Plasma apps
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    oxygen
  ];

  # Set adwaita dark theme
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

}
