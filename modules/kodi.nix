{ config, lib, pkgs, ... }: {

  # OPTIONS
  options = {
    modules.kodi = {
      enable = lib.mkEnableOption "";
    };
  };
  
  # CONFIG
  config = lib.mkIf config.modules.kodi.enable {
    # Add Kodi package and addons
    environment.systemPackages = [
	    (pkgs.kodi.withPackages (kodiPkgs: with kodiPkgs; [
		    jellyfin
	    ]))
    ];
  };

}
