{ config, pkgs, ... }: {

  imports = [
    # Replace with your host config (e.g., hosts/thinkpad.nix)
    ./hosts/example.nix
  ];
