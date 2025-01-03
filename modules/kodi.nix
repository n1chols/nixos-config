{ config, lib, pkgs, ... }: {

  # OPTIONS
  options = {
    modules.kodi = {
      enable = lib.mkEnableOption "";
    };
  };
  
  # CONFIG
  config = lib.mkIf config.modules.kodi.enable {

    services.xserver.desktopManager.kodi.enable = true;

    security.rtkit.enable = true;
    services.pipewire.enable = true;
    services.pipewire.pulse.enable = true;
    services.xserver.enable = true;

    environment.systemPackages = [ pkgs.libcec ];

    users.users.kodi = {
      isNormalUser = true;
      extraGroups = [ "input" "video" "audio"];
    };

    services.xserver.displayManager.autoLogin.enable = true;
    services.xserver.displayManager.autoLogin.user = "kodi";
    
  };

}
