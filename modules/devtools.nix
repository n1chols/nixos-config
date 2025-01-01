{ config, lib, pkgs, ... }: {

  # OPTIONS
  options = {
    modules.devtools = {
      enable = lib.mkEnableOption "";
    };
  };
  
  # CONFIG
  config = lib.mkIf config.modules.devtools.enable {
    # Add basic packages
    environment.systemPackages = with pkgs; [
      git
      wget
      curl
      bash
      python3
    ];
  };

}
