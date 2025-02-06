{ config, lib, pkgs, ... }: {

  # OPTIONS
  options.modules.update = {
    enable = lib.mkEnableOption "";
    host = lib.mkOption {
      type = lib.types.str;
    };
  };

  # CONFIG
  config = lib.mkIf config.modules.update.enable {
    
  };

}
