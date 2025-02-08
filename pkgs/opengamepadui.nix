{ config, lib, pkgs, ... }: {

  # Enable OpenGamepadUI
  programs.opengampadui = {
    enable = true;
    gamescopeSession.Args = [
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
