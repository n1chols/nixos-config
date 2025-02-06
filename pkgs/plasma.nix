{ config, lib, pkgs, ... }: {
  
  # Enable KDE Plasma
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;

  # TESTING STUFF
  services.displayManager.sddm.enable = true;

  services.displayManager.defaultSession = "plasma";

  programs.xwayland.enable = true;

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    wayland
    libsForQt5.qt5.qtwayland
    qt6.qtwayland
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
