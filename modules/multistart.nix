{ config, lib, pkgs, ... }: {

  # OPTIONS
  options.modules.multistart = {
    enable = lib.mkEnableOption "";
    sessions = lib.mkOption {
      type = lib.types.listOf lib.types.str;
    };
  };

  # CONFIG
  config = lib.mkIf config.modules.multistart.enable {
    # Enable autologin
    services.getty.autologinUser = "user";

    services.xserver = {
      enable = true;
      displayManager = {
        lightdm.enable = true;
        # Create session files in the xsessions directory
        session = lib.imap0 (index: session: {
          name = "custom-session-${toString index}";
          start = ''
            ${session}
          '';
        }) config.modules.multistart.sessions;
      };
    };
  };

}
