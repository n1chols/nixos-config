{ config, pkgs, ... }: {

  # WiFi
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  users.users.user.extraGroups = [ "networkmanager" ];

  # Bluetooth
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true;

};
