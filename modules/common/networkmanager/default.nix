{ lib, ... }: {
  # Enable NetworkManager
  networking = {
    networkmanager.enable = true;
    useDHCP = lib.mkDefault true;
  };
}
