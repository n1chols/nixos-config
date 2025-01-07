{ config, lib, pkgs, ... }: {

  # Override vulnerable dependency
  nixpkgs.overlays = [
    (final: prev: {
      emulationstation-de = prev.emulationstation-de.override {
        freeimage = prev.freeimage;
      };
    })
  ];

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

}
