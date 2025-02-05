{ config, lib, pkgs, ... }: {

  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    withUWSM = false;
  };

  # Required environment variables for Wayland
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };

}
