{ config, lib, pkgs, ... }:

# Helper function to create a systemd service for each session
let
  createSessionService = sessionName: ttyIndex: {
    systemd.services."multistart-session-${sessionName}" = {
      description = "Start ${sessionName}";
      after = [ "graphical.target" ];
      serviceConfig = {
        ExecStart = "${sessionName}";
        TTYPath = "/dev/tty${ttyIndex}";
        StandardInput = "tty";
        StandardOutput = "tty";
        StandardError = "tty";
      };
    };
  };
  
in {

  # Define the options for the multistart module
  options.modules.multistart = {
    enable = lib.mkEnableOption "";
    sessions = lib.mkOption {
      type = lib.types.listOf lib.types.str;
    };
  };

  # Apply the configuration if multistart is enabled
  config = lib.mkIf config.modules.multistart.enable {
    # Generate a systemd service for each session
    let
      sessions = config.modules.multistart.sessions;
    in
    # Dynamically generate a service for each session
    builtins.listToAttrs (lib.listToAttrs (builtins.map (sessionName: 
      let
        ttyIndex = builtins.elemAt sessions (builtins.indexOf sessions sessionName);
      in
        createSessionService sessionName ttyIndex
    ) sessions));
  };
}
