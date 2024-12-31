{ config, pkgs, ... }: {

  # Hyprland
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  users.users.user.extraGroups = [ "video" ];

};
