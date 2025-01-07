{ config, lib, pkgs, ... }: {

  # Install ES-DE and emulators
  environment.systemPackages = with pkgs; [
    (emulationstation-de.override { freeimage = freeimage; })
    flycast
    mupen64plus
    melonds
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
