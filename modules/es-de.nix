{ config, lib, pkgs, ... }: {

  # OPTIONS
  options = {
    modules.es-de = {
      enable = lib.mkEnableOption "";
    };
  };
  
  # CONFIG
  config = lib.mkIf config.modules.es-de.enable {
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
  };

}
