{ config, pkgs, ... }: {

  # Setup EFI boot loader
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # Enable NetworkManager
  networking.networkmanager.enable = true;

  # Create user account with sudo and network access
  users.users.user = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  # Allow proprietary software
  nixpkgs.config.allowUnfree = true;

  # Disable documentation and xterm
  documentation.nixos.enable = false;

  services.xserver.excludePackages = [ pkgs.xterm ];

  # NixOS config version
  system.stateVersion = "24.11";

}
