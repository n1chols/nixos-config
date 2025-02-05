{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      htpc = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/htpc.nix ];
      };
      thinkpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [ ./hosts/thinkpad.nix ];
      };
    };
  };
}
