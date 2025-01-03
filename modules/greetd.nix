{ config, lib, pkgs, ... }: {

  # OPTIONS
  options.modules.greetd = {
    enable = lib.mkEnableOption "";
    defaultSession = lib.mkOption {
      type = lib.types.str;
    };
    otherSessions = lib.mkOption {
      default = [];
      type = lib.types.listOf lib.types.str;
    };
  };

  # CONFIG
  config = lib.mkIf config.modules.greetd.enable {
    # Enable autologin
    services.getty.autologinUser = "user";

    # Enable greetd
    services.greetd = {
      enable = true;
      settings = {
        default_session = {
          command = config.modules.greetd.defaultSession;
          user = "user";
        };
        terminals = lib.listToAttrs (lib.imap0 (index: session: {
          name = "terminal${toString index}";
          value = {
            command = session;
            user = "user";
          };
        }) config.modules.greetd.otherSessions);
      };
    };
  };

}
