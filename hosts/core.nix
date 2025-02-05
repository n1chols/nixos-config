{ config, pkgs, ... }: {

  # Boot
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Network
  networking.networkmanager.enable = true;

  # User
  users.users.user = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # Packages
  nixpkgs.config.allowUnfree = true;

  documentation.nixos.enable = false;

  services.xserver.excludePackages = [ pkgs.xterm ];

  # Version
  system.stateVersion = "24.11";

}
