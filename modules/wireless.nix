{ config, pkgs, ... }: {
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  users.users.user.extraGroups = [ "networkmanager" ];
}
