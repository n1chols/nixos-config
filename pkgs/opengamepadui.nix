{ config, lib, pkgs, ... }: {

  # Enable OpenGamepadUI
  programs.opengamepadui = {
    enable = true;
    gamescopeSession.args = [
      "--backend drm"
      "--expose-wayland"
      "--fullscreen"
      "--immediate-flips"
      "--rt"
      "-W 3840"
      "-H 2160"
      "-r 120"
      "--adaptive-sync"
      "--hdr-enabled"
      "--hdr-itm-enable"
    ];
  };

}
