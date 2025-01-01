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
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    steam-hardware.enable = true;
    xpadneo.enable = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  users.users.user.extraGroups = [ "input" ];

};
