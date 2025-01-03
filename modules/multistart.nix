{ config, lib, pkgs, ... }:

let
  # Helper function to create a systemd unit
  createSessionService = sessionName: ttyIndex: {
    # Define the systemd service for the session
    systemd.services."multistart-session-${sessionName}" = {
      description = "Start ${sessionName}";
      after = [ "graphical.target" ];
      # We define which TTY the session should be associated with
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

  options.modules.multistart = {
    enable = lib.mkEnableOption "";
    sessions = lib.mkOption {
      type = lib.types.listOf lib.types.str;
    };
  };

  config = lib.mkIf config.modules.multistart.enable {
    
    # Iterate over the list of sessions and create a systemd service for each
    let
      sessions = config.modules.multistart.sessions;
    in
    builtins.listToAttrs (lib.listToAttrs (builtins.listMap (sessionName: 
      let ttyIndex = builtins.elemAt sessions (builtins.indexOf sessions sessionName);
      in createSessionService sessionName ttyIndex
    ) sessions));

  };
}

