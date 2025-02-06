{ config, lib, pkgs, ... }: {

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = false;
  };

  # Enable XDG desktop portal
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk
    ];
  };

  # Install desktop utilities
  environment.systemPackages = with pkgs; [
    dunst
    waybar
    rofi-wayland
    wl-clipboard
  ];

}
