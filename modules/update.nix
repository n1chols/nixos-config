{ config, lib, pkgs, ... }: {

  # OPTIONS
  options.modules.update = {
    enable = lib.mkEnableOption "";
    repo = lib.mkOption {
      type = types.str;
    };
  };

  # CONFIG
  config = lib.mkIf config.modules.update.enable {
    # Install git
    environment.systemPackages = with pkgs; [
      git
    ];

    # Add shell command
    environment.shellAliases = {
      "reconfig" = ''
        cd /etc/nixos && \
        sudo git pull || \
        sudo git clone $(config.system.update.repo) . && \
        sudo nixos-rebuild switch
      '';
    };
  };

}
