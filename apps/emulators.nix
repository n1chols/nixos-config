{ config, lib, pkgs, ... }: {

  # Install Emulators and Steam ROM Manager
  environment.systemPackages = with pkgs; [
    steam-rom-manager
    bottles
    waydroid
    melonDS
    cemu
    ryujinx
  ];

}
