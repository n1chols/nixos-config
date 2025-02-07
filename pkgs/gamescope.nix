{ config, lib, pkgs, ... }: {

  # Enable Gamescope
  programs.gamescope = {
    enable = true;
    env = {
      "ENABLE_GAMESCOPE_WSI" = 1;
    };
    args = [
      "--backend drm"
      "--expose-wayland"
      "--fullscreen"
      "--immediate-flips"
      "--rt"
    ];
  };

  # Set capabilities for gamescope
  security.wrappers.gamescope = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_nice+eip";
    source = "${pkgs.gamescope}/bin/gamescope";
  };

}
