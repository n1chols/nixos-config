{ config, lib, pkgs, ... }: {
  
  # Enable KDE Plasma
  #services.xserver.enable = true;
  #services.desktopManager.plasma6.enable = true;

  # TESTING STUFF
  # Clear out any KDE 5 residuals and ensure Plasma 6
  services.xserver = {
    enable = true;
    displayManager = {
      sddm.enable = true;
      defaultSession = "plasma"; # Should be "plasma" not "plasmawayland"
    };
    desktopManager.plasma6.enable = true;
  };

  environment.systemPackages = with pkgs.kdePackages; [
    plasma-workspace
    plasma-desktop
    kwin
    qtwayland
  ];

  # Enable XDG desktop portal
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-kde ];
  };

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
