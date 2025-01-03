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

  # CONFIG
  config = lib.mkIf config.modules.greetd.enable {
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = config.modules.greetd.defaultSession;
        };
      };
    };
  };

}
