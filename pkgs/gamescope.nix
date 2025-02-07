{ config, lib, pkgs, ... }: {

  # Enable Gamescope
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

}
