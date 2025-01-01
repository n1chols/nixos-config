{ config, lib, pkgs, ... }: {
  options = {
    modules.steam = {
      enable = lib.mkEnableOption "";
      gamepadSupport = lib.mkEnableOption "";
      addSessionEntry = lib.mkEnableOption "";
    };
  };

  config = lib.mkIf config.modules.steam.enable {
    # Enable graphics and gamepad support
    hardware = {
      graphics = {
        enable = true;
        enable32Bit = true;
      };
      steam-hardware.enable = config.modules.steam.gamepadSupport;
      xpadneo.enable = config.modules.steam.gamepadSupport;
    };
    # Enable Steam and session entry
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = config.modules.steam.addSessionEntry;
    };
  };
}
