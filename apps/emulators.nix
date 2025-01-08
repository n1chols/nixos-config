{ config, lib, pkgs, ... }: {

  # Install Emulators and Steam ROM Manager
  environment.systemPackages = with pkgs; [
    sgdboop
    melonDS
    cemu
    ryujinx
  ];

}
