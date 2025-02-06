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

  # Disable documentation and xterm apps
  documentation.nixos.enable = false;

  services.xserver.excludePackages = [ pkgs.xterm ];

  # Allow proprietary software
  nixpkgs.config.allowUnfree = true;

  # Configure common modules
  modules = {
    dotfiles = {
      enable = true;
      host = name;
    };
    update = {
      enable = true;
      repo = "https://github.com/tob4n/nixos-config";
    };
  };

  # NixOS config version
  system.stateVersion = "24.11";

}
