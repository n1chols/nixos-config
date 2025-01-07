{ config, lib, pkgs, ... }: {

  # Install ES-DE and emulators
  environment.systemPackages = with pkgs; [
    emulationstation-de
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

  # Allow insecure dependency
  nixpkgs.config.permittedInsecurePackages = [
    "freeimage-unstable-2021-11-01"
  ];

}
