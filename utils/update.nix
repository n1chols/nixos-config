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
    # Install git and update script
    environment.systemPackages = with pkgs; [
      git
      (pkgs.writeShellScriptBin "update" ''
        #!${pkgs.bash}/bin/bash
        set -e
        cd /etc/nixos
        sudo find . -mindepth 1 -delete
        sudo git clone ${config.modules.update.repo} .
        if [ -n "$1" ]; then
          sudo nixos-rebuild switch --flake .#$1 --no-write-lock-file
        else
          sudo nixos-rebuild switch --flake . --no-write-lock-file
        fi
      '')
    ];
  };

}
