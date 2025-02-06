{ config, lib, pkgs, ... }: {

  # HOST NAME / TIME ZONE
  networking.hostName = "Thinkpad X230";
  time.timeZone = "America/Los_Angeles";
  
  # HARDWARE / DRIVERS
    
  # FILE SYSTEM
  
  # IMPORTS / MODULES
  imports = [
    ../pkgs/common.nix
    ../pkgs/hyprland.nix
    ../modules/update.nix
    ../modules/sessions.nix
    ../modules/dotfiles.nix
  ];

  modules = {
    sessions = {
      enable = true;
      commands = [
        "${pkgs.dbus}/bin/dbus-run-session env XDG_SESSION_TYPE=wayland ${pkgs.hyprland}/bin/Hyprland"
      ];
    };
  };

}
