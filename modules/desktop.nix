
# Hyprland configuration
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Enable XDG portal with proper backends
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    config.common.default = "*";
  };

users.users.user.extraGroups = [ "video" ];
