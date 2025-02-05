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
        sudo rm -rf ./*
        sudo git clone ${config.modules.update.repo} .
        if [ -n "$1" ]; then
          sudo nixos-rebuild switch --flake .#$1
        else
          sudo nixos-rebuild switch --flake .
        fi
      '')
    ];
  };

}
