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
        args = [ "-steamos3" "-gamepadui" ];
      };
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        gamescopeSession = {
          enable = config.modules.steam.addSessionEntry;
          args = [ "-steamos3" "-gamepadui" ];
        };
      };
    };

    ## Fix Steam 'Switch to Desktop'
    #environment.systemPackages = with pkgs; [
    #  (writeScriptBin "steamos-session-select" ''
    #    #!${stdenv.shell}
    #    steam -shutdown
    #  '')
    #];

    # Hack?
    users.users.steamuser = {
      isSystemUser = true;
      uid = config.users.users.user.uid;
    };

    # Install necessary packages
    environment.systemPackages = with pkgs; [
      vulkan-tools
      vulkan-loader
      vulkan-validation-layers
      (writeShellScriptBin "steamos-session-select" ''
        steam -shutdown
      '')
    ];
  };

}
