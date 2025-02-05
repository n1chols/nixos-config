{ config, lib, pkgs, ... }: {

  # Install ES-DE
  environment.systemPackages = with pkgs; [
    emulationstation-de
  ];

}
