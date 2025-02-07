{ config, lib, pkgs, ... }: {
  
  # Install Pegasus
  environment.systemPackages = with pkgs; [
    pegasus-frontend
  ];

}
