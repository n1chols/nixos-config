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

  # Setup Hyprland config
  environment.etc."hyprland.conf".text = ''
    monitor=,preferred,auto,1

    exec-once = waybar
    exec-once = dunst

    bind = SUPER, T, exec, kitty
    bind = SUPER, Q, exec, rofi --show drun
    bind = SUPER, X, killactive
    bind = SUPER, F, fullscreen
  '';

}
