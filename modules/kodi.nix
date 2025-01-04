{ config, lib, pkgs, ... }: {

  # OPTIONS
  options = {
    modules.kodi = {
      enable = lib.mkEnableOption "";
    };
  };
  
  # CONFIG
  config = lib.mkIf config.modules.kodi.enable {
    # Add Kodi package, compositor, and addons
    environment.systemPackages = with pkgs; [
      cage
      kodi.override {
        extraAddons = {
          repository-umbrella = pkgs.fetchzip {
            url = "https://umbrellaplug.github.io/repository.umbrella-2.2.6.zip";
            sha256 = "sha256-XXXXX";
          };
          repository-cocoscrapers = pkgs.fetchzip {
            url = "https://cocojoe2411.github.io/repository.cocoscrapers-1.0.0.zip";
            sha256 = "sha256-XXXXX";
          };
        };
      }
    ];
  };

}
