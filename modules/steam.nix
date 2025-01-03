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
      gamescope.enable = true;
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        gamescopeSession = {
          enable = config.modules.steam.addSessionEntry;
          env = {
            STEAMCMD = "steam -gamepadui -steamos3 -steampal -steamdeck %command%";
          };
        };
      };
    };

    system.activationScripts.steamosSessionSelect = ''
      mkdir -p /usr/bin
      cat > /usr/bin/steamos-session-select << 'EOF'
      #!/bin/sh
      steam -shutdown
      EOF
      chmod +x /usr/bin/steamos-session-select
    '';

    # Install necessary packages
    environment.systemPackages = with pkgs; [
      vulkan-tools
      vulkan-loader
      vulkan-validation-layers
    ];
  };

}
