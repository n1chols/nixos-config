{ config, pkgs, ... }: {

  # Bluetooth
  hardware.bluetooth.enable = true;

  # Blueman
  services.blueman.enable = true;

}
