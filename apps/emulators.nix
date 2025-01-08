{ config, lib, pkgs, ... }: {

  # Install Emulators
  environment.systemPackages = with pkgs; [
    lutris
    cemu
    ryujinx
  ];

}
