{
  description = "NixOS config by tob4n";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = { self, nixpkgs }@inputs: {
    nixosConfigurations = {
      thinkpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/thinkpad.nix
          ./modules/core.nix
          ./modules/desktop.nix
          ./modules/wireless.nix
          ./modules/audio.nix
          ./modules/web.nix
          ./modules/gaming.nix
          ./modules/virtualization.nix
          ./modules/development.nix
          ./modules/hardening.nix
        ];
      };
      htpc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/htpc.nix
          ./modules/core.nix
          ./modules/desktop.nix
          ./modules/audio.nix
          ./modules/web.nix
          ./modules/gaming.nix
          ./modules/virtualization.nix
        ];
      };
    };
  };
}
