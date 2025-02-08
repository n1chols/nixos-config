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

  # Install desktop packages
  environment.systemPackages = with pkgs; [
    dunst
    rofi-wayland
  ];

  # Install fonts for theming
  fonts.packages = with pkgs; [
    font-awesome_6
    cantarell-fonts
  ];

}
