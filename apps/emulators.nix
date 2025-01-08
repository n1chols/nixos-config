{ config, lib, pkgs, ... }: {

  # Install Emulators
  environment.systemPackages = with pkgs; [
    melonDS
    lime3ds
    cemu
    ryujinx
  ];

}
