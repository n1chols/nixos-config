{ config, lib, pkgs, ... }: {

  # Install git and update command
  environment.systemPackages = with pkgs; [
    git
    (pkgs.writeShellScriptBin "update" ''
      #!${pkgs.bash}/bin/bash
      set -e
      cd /etc/nixos
      sudo find . -mindepth 1 -delete
      sudo git clone https://github.com/n1chols/nixos-config .
      if [ -n "$1" ]; then
        sudo nixos-rebuild switch --flake .#$1 --no-write-lock-file
      else
        sudo nixos-rebuild switch --flake . --no-write-lock-file
      fi
    '')
  ];

}
