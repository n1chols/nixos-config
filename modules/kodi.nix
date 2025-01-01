{ config, lib, pkgs, ... }: {

  # OPTIONS
  options = {
    modules.kodi = {
      enable = lib.mkEnableOption "Kodi media center";
      addSessionEntry = lib.mkEnableOption "Add Kodi as a session entry";
    };
  };
  
  # CONFIG
  config = lib.mkIf config.modules.kodi.enable {
    # Add Kodi package
    environment.systemPackages = [ pkgs.kodi ];
    
    # Add Wayland session entry
    services.xserver.desktopManager.kodi.enable = config.modules.kodi.addSessionEntry;
    
    # Enable required services
    services.udisks2.enable = true;
    xdg.portal.enable = true;
  };

}
