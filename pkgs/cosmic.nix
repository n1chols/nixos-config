{ config, lib, pkgs, ... }:

let
  cosmic = builtins.getFlake "github:lilyinstarlight/nixos-cosmic";
in
{
  imports = [
    cosmic.nixosModules.default
  ];

  # Enable required services and settings for COSMIC
  services = {
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;
    flatpak.enable = true;  # For COSMIC Store
  };

  # Add the Cosmic binary cache
  nix.settings = {
    substituters = [ "https://cosmic.cachix.org/" ];
    trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
  };

  environment.sessionVariables = {
    COSMIC_DATA_CONTROL_ENABLED = "1";
  };

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
}
