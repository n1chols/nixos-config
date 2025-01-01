{ config, pkgs, ... }: {

  # Host
  imports = [
    # Replace with your host config (e.g., hosts/thinkpad.nix)
    ./hosts/example.nix
  ];

  # Boot
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };
  
  # User
  users.users.user = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

};
