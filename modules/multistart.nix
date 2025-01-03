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
    systemd.services = lib.concatMapStringsSep "\n" (sessionName: ''
      [Service]
      ExecStart=${sessionName}
      TTYPath=/dev/tty${builtins.indexOf config.modules.multistart.sessions sessionName + 1}
      StandardInput=tty
      StandardOutput=tty
      StandardError=tty
    '') config.modules.multistart.sessions;
  };

}
