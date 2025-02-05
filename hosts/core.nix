{ config, pkgs, ... }: {

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.networkmanager.enable = true;

  users.users.user = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  nixpkgs.config.allowUnfree = true;

  documentation.nixos.enable = false;

  services.xserver.excludePackages = [ pkgs.xterm ];

  system.stateVersion = "24.11";

}
