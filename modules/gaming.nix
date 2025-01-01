{ config, pkgs, ... }: {

  # Zen Kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # GameMode
  programs.gamemode.enable = true;

  users.users.user.extraGroups = [ "gamemode" ];
  
  # Steam
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
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

}
