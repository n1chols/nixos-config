{ config, pkgs, ... }: {

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
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
