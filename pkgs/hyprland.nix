{ config, lib, pkgs, ... }: {

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = false;
  };

  # Install desktop utilities
  environment.systemPackages = with pkgs; [
    rofi-wayland
    kitty
    waybar
    dunst
    wl-clipboard
    pavucontrol
    networkmanagerapplet
    blueman
  ];

}
