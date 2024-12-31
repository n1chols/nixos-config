{ config, pkgs, ... }: {

  # Zen Kernel
  boot.kernelPackages = linuxPackages_zen;

  # GameMode
  programs.gamemode = {
    enable = true;
    settings = {};
  };

  users.users.user.extraGroups = [ "gamemode" ];

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  users.users.user.extraGroups = [ "input" ];

};
