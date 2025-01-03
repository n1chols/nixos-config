{ config, lib, pkgs, ... }: {

  # OPTIONS
  options = {
    modules.kodi = {
      enable = lib.mkEnableOption "";
    };
  };
  
  # CONFIG
  config = lib.mkIf config.modules.kodi.enable {

    users.extraUsers.kodi.isNormalUser = true;
    services.cage.user = "kodi";
    services.cage.program = "${pkgs.kodi-wayland}/bin/kodi-standalone";
    services.cage.enable = true;
    
  };

}
