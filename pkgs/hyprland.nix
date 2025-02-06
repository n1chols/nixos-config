{ config, lib, pkgs, ... }: {

  # Enable Hyprland and waybar
  programs = {
    hyprland = {
      enable = true;
      withUWSM = false;
    };
    waybar = {
      enable = true;
    };
  };

  # Install desktop utilities
  environment.systemPackages = with pkgs; [
    dunst
    rofi-wayland
    wl-clipboard
  ];

}
