{ config, lib, pkgs, ... }: {

  # OPTIONS
  options.modules.multistart = {
    enable = lib.mkEnableOption "";
    sessions = lib.mkOption {
      type = lib.types.listOf lib.types.str;
    };
  };

  # CONFIG
  config = lib.mkIf config.modules.multistart.enable {

    services.greetd = {
      enable = true;
      settings.default_session = {
        command = "dbus-run-session ${pkgs.kodi}/bin/kodi --standalone & waitPID=$!";
        user = "user";
      };
    };
  
    # dbus-run-session env XDG_SESSION_TYPE=wayland gnome-session
    # ${pkgs.gamescope}/bin/gamescope -- ${pkgs.steam}/bin/steam -tenfoot -pipewire-dmabuf
    # ${pkgs.kodi-wayland}/bin/kodi-standalone

  };

}
