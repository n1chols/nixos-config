{ config, lib, pkgs, ... }: {

  # Enable Gamescope
  programs.gamescope = {
    enable = true;
    capSysNice = true;
    args = [
      "--backend drm"
      "--immediate-flips"
      "--rt"
      "--fullscreen"
    ];
  };
  
  # Install Pegasus
  environment.systemPackages = with pkgs; [
    pegasus-frontend
  ];

}
