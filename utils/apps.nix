{ config, lib, pkgs, ... }: {

  # OPTIONS
  options.modules.apps = {
    enable = lib.mkEnableOption "";
    emulators = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
    devtools = lib.mkOption {
      type = lib.types.bool;
      default = false;
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
    ] 
    ++ lib.optionals config.modules.apps.emulators [
      # Install emulators
      cemu
      ryujinx
      waydroid
    ]
    ++ lib.optionals config.modules.apps.devtools [
      # Install dev tools
      vscodium
      android-studio
      android-tools
      jetbrains.idea-ultimate
      jetbrains.pycharm-professional
      jetbrains.webstorm
      jetbrains.datagrip
      jetbrains.clion
      jetbrains.rider
    ];
  };

}
