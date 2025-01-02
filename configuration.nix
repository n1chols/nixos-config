{ config, pkgs, ... }: {

  # Host
  imports = [
    # Replace with your host config (e.g., hosts/thinkpad.nix)
    ./hosts/htpc.nix
  ];

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

  # Documentation
  documentation.nixos.enable = false;

  # Version
  system.stateVersion = "24.11";

}
