{ config, lib, pkgs, ... }: {

  # OPTIONS
  options.modules.apps = {
    enable = lib.mkEnableOption "";
    emulators = lib.mkOption {
      type = lib.types.bool;
    };
    devtools = lib.mkOption {
      type = lib.types.bool;
    };
  };

  # CONFIG
  config = lib.mkIf config.modules.sessions.enable {
    environment.systemPackages = with pkgs; [
      # Install core desktop apps
      librewolf
      loupe
      celluloid
      nautilus
      file-roller
      gnome-text-editor
      gnome-disk-utility
      mission-center
      blackbox-terminal
      fragments
      bottles
      ghex
      appimage-run

      # Install emulators
      (lib.optionals config.modules.apps.emulators [
        dolphin-emu
        cemu
        ryujinx
        waydroid
      ])

      # Install dev tools
      (lib.optionals config.modules.apps.devtools [
        vscodium
        android-studio
        android-tools
        jetbrains.idea-ultimate
        jetbrains.pycharm-professional
        jetbrains.webstorm
        jetbrains.datagrip
        jetbrains.clion
        jetbrains.rider
      ])
    ];
  };

}
