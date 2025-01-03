{ config, lib, pkgs, ... }: {

  # Define the options for the multistart module
  options.modules.multistart = {
    enable = lib.mkEnableOption "";
    sessions = lib.mkOption {
      type = lib.types.listOf lib.types.str;
    };
  };

  # Apply the configuration if multistart is enabled
  config = lib.mkIf config.modules.multistart.enable {
  
    # Generate systemd services for each session
    systemd.services = lib.mkMerge (lib.mapAttrs (index: sessionName: {
      # Each service is named based on the session name
      "multistart-session-${index}" = {
        description = "Start ${sessionName}";
        after = [ "graphical.target" ];
        serviceConfig = {
          ExecStart = "${sessionName}";
          TTYPath = "/dev/tty${index + 1}";  # Map the index to tty1, tty2, etc.
          StandardInput = "tty";
          StandardOutput = "tty";
          StandardError = "tty";
        };
      };
    }) (lib.attrNames config.modules.multistart.sessions));
  };

}
