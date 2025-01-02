{ config, lib, pkgs, ... }: {

  # OPTIONS
  options = {
    modules.steam = {
      enable = lib.mkEnableOption "";
      addSessionEntry = lib.mkEnableOption "";
    };
  };
  
  # CONFIG
  config = lib.mkIf config.modules.steam.enable {
    # Enable Steam and Wayland session entry
    programs = {
      gamescope = {
        enable = true;
        args = [ "-steamos3" ];
      };
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        gamescopeSession.enable = config.modules.steam.addSessionEntry;
      };
    };

    ## Fix Steam 'Switch to Desktop'
    #environment.systemPackages = with pkgs; [
    #  (writeScriptBin "steamos-session-select" ''
    #    #!${stdenv.shell}
    #    steam -shutdown
    #  '')
    #];

    # Install necessary packages
    environment.systemPackages = with pkgs; [
      vulkan-tools
      vulkan-loader
      vulkan-validation-layers
      (writeScriptBin "steamos-session-select" ''
        #!${stdenv.shell}
        steam -shutdown
      '')
    ];
  };

}
