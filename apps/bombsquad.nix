{ config, lib, pkgs, ... }: {

  # Install BombSquad
  environment.systemPackages = with pkgs; [
    bombsquad
  ];

}
