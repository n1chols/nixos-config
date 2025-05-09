{ pkgs, ... }: {
  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Remove default packages
  environment.defaultPackages = [];
  services.xserver.excludePackages = [ pkgs.xterm ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable all firmware
  hardware.enableAllFirmware = true;
}
