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

  # Utilities
  environment.systemPackages = with pkgs; [
    kitty
    waybar
    wofi
    mako
    libnotify
    wl-clipboard
    nnn
    imv
    mpv
  ]

};
