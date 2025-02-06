{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations = {
      htpc = nixpkgs.lib.nixosSystem {
        modules = [ ./hosts/htpc.nix ];
      };
      thinkpad = nixpkgs.lib.nixosSystem {
        modules = [ ./hosts/thinkpad.nix ];
      };
    };
  };
}
