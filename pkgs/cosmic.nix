{ config, lib, pkgs, ... }:

let
  cosmicTarball = fetchTarball {
    url = "https://github.com/lilyinstarlight/nixos-cosmic/archive/main.tar.gz";
    # You'll want to update this hash periodically
    sha256 = "sha256:0000000000000000000000000000000000000000000000000000"; # Replace with actual hash
  };
in
{
  imports = [
    "${cosmicTarball}/modules/cosmic.nix"
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
}
