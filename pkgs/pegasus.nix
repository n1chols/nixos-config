{ config, lib, pkgs, ... }: {

  # Enable Gamescope
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
  
  # Install Pegasus
  environment.systemPackages = with pkgs; [
    pegasus-frontend
  ];

}
