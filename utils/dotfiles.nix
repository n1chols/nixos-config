{ config, lib, pkgs, ... }: {

  # OPTIONS
  options.modules.dotfiles = {
    enable = lib.mkEnableOption "";
    host = lib.mkOption {
      type = lib.types.str;
    };
  };

  # CONFIG
  config = lib.mkIf config.modules.dotfiles.enable {
    system.activationScripts.copyDotfiles = let
      sourceDir = ../hosts + "/${config.modules.dotfiles.host}/home";
    in ''
      cp -a ${sourceDir}/. /home/user/
    '';
  };

}
