{ config, pkgs, name, ... }: {

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

  # Apply host dotfiles
  system.activationScripts.copyDotfiles = ''
    cp -a ../hosts/${name}/home/. /home/user/
  '';

  # Disable documentation and xterm apps
  documentation.nixos.enable = false;

  services.xserver.excludePackages = [ pkgs.xterm ];

  # Allow proprietary software
  nixpkgs.config.allowUnfree = true;

  # NixOS config version
  system.stateVersion = "24.11";

}
