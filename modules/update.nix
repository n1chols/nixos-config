{ config, lib, pkgs, ... }: {

  # OPTIONS
  options.modules.update = {
    enable = lib.mkEnableOption "";
    repo = lib.mkOption {
      type = lib.types.str;
    };
  };

  # CONFIG
  config = lib.mkIf config.modules.update.enable {
    # Install git and custom script
    environment.systemPackages = with pkgs; [
      git
      (pkgs.writeShellScriptBin "update" ''
        #!${pkgs.bash}/bin/bash
        set -e
        cd /etc/nixos
        sudo git clean -fd
        sudo git fetch origin
        sudo git reset --hard origin/main
        if [ -n "$1" ]; then
          sudo nixos-rebuild switch --flake .#$1
        else
          sudo nixos-rebuild switch --flake .
        fi
      '')
    ];
  };

}
