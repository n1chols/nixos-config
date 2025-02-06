{ config, lib, pkgs, ... }: {

  # Enable Roon Server
  services.roon-server = {
    enable = true;
    openFirewall = true;
  };

}
