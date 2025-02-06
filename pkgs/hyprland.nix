{ config, lib, pkgs, ... }: {

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = false;
    settings = {
      monitor = [
        ",preferred,auto,1"
      ];
        
      exec-once = [
        "waybar"
        "dunst"
      ];
        
      bind = [
        "SUPER, Q, exec, rofi --show drun"
        "SUPER, T, exec, kitty"
        "SUPER, F, fullscreen"
      ];

      input = {
        kb_layout = "us";
        follow_mouse = 1;
      };
    };
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
