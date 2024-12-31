{ config, pkgs, ... }: {

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  users.users.user.extraGroups = [ "input" ];

  # GameMode
  programs.gamemode = {
    enable = true;
    settings = {};
  };

  users.users.user.extraGroups = [ "gamemode" ];

};
