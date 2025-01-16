{ config, lib, pkgs, ... }: {

  # Install Roon
  environment.systemPackages = with pkgs; [
    roon-server
  ];

}
