{ config, lib, pkgs, ... }: {

  # Install Emulators
  environment.systemPackages = with pkgs; [
    flycast
    mupen64plus
    melonDS
    lime3ds
    dolphin-emu
    cemu
    ryujinx
    duckstation
    pcsx2
    rpcs3
    xemu
  ];

}
