{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    steam-console.url = "github:n1chols/nixos-steam-console";
  };

  outputs = { self, nixpkgs, steam-console }: let
    lib = nixpkgs.lib;
  in {
    nixosConfigurations = {
      htpc = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/common/basic
          ./modules/common/networkmanager
          ./modules/common/pipewire
          ./modules/common/bluetooth
          ./modules/common/plasma
          ./modules/host/htpc
          ./modules/user/user
          steam-console.modules.default
          {
            services.roon-server = {
              enable = true;
              openFirewall = true;
            };
            steam-console = {
              enable = true;
              enableHDR = true;
              enableVRR = true;
              enableDecky = true;
              user = "user";
              desktopSession = "startplasma-wayland";
            };
          }
        ];
      };
      thinkpad = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./modules/common/basic
          ./modules/common/networkmanager
          ./modules/common/pipewire
          ./modules/common/bluetooth
          ./modules/common/printing
          ./modules/common/plasma
          ./modules/host/thinkpad
          ./modules/user/user
        ];
      };
    };
  };
}
