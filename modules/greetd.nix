{ config, lib, pkgs, ... }: {

  # OPTIONS
  options.modules.greetd = {
    enable = lib.mkEnableOption "";
    defaultSession = lib.mkOption {
      type = lib.types.str;
    };
    otherSessions = lib.mkOption {
      type = lib.types.listOf lib.types.str;
    };
  };

}
