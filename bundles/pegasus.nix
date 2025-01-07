{ config, lib, pkgs, ... }: {

  # Install ES-DE and emulators
  environment.systemPackages = with pkgs; [
    pegasus-frontend
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
