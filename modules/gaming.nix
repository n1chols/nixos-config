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
  programs = {
    gamescope = {
      enable = true;
      capSysNice = true;
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
  
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    steam-hardware.enable = true;
    xpadneo.enable = true;
  };

  users.users.user.extraGroups = [ "input" ];

};
