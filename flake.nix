{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = let
      hosts = builtins.readDir ./hosts;
      mkHost = name: nixpkgs.lib.nixosSystem {
        specialArgs = { inherit name; };
        modules = [
          ./pkgs/common.nix
          ./hosts/${name}
        ];
      };
    in builtins.mapAttrs (name: _: mkHost name) hosts;
  };
}
