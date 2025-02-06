{ config, lib, pkgs, ... }: {

  # Enable Hyprland and waybar
  programs = {
    hyprland = {
      enable = true;
      withUWSM = false;
    };
    waybar = {
      enable = true;
      package = pkgs.waybar.overrideAttrs (oldAttrs: {
         mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    };
  };

  # Disable wallpaper splash text
  services.hyprpaper = {
    enable = true;
    settings.splash = false;
  };

  # Install desktop utilities
  environment.systemPackages = with pkgs; [
    dunst
    kitty
    rofi-wayland
  ];

}
