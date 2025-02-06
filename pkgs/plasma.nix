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

  environment.systemPackages = with pkgs; [
    wayland
    qt6.qtwayland
    qt6.full
  ] ++ (with pkgs.kdePackages; [
    plasma-workspace
    kwin
    plasma-desktop
    kdeplasma-addons
    plasma-integration
    plasma-pa  # Audio integration
    kwayland
    layer-shell-qt
  ]);

  # Enable XDG desktop portal
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
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
