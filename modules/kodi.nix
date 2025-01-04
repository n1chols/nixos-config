{ config, lib, pkgs, ... }: {

  # OPTIONS
  options = {
    modules.kodi = {
      enable = lib.mkEnableOption "";
    };
  };
  
  # CONFIG
  config = lib.mkIf config.modules.kodi.enable {
    # Add Kodi package
    environment.systemPackages = with pkgs; [
      kodi-wayland
      cage
      wlr-randr
    ];
  };

}
