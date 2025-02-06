{ config, lib, pkgs, ... }: {
  
  # Enable KDE Plasma
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Force adwaita dark theme
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  # Disable unnecessary Plasma apps
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    plasma-browser-integration
    konsole
    oxygen
  ];

}
