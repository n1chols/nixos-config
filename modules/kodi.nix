{ config, lib, pkgs, ... }: {

  # OPTIONS
  options = {
    modules.kodi = {
      enable = lib.mkEnableOption "";
    };
  };
  
  # CONFIG
  config = lib.mkIf config.modules.kodi.enable {

    services.kodi.enable = true;
    services.kodi.openFirewall = true;

    security.rtkit.enable = true;
    services.pipewire.enable = true;
    services.pipewire.pulse.enable = true;
    services.xserver.enable = true;
    
  };

}
