{
  inputs = {
    flex-system.url = "github:n1chols/nixos-flex-system";
    steam-console.url = "github:n1chols/nixos-steam-console";
  };

  outputs = { flex-system, steam-console }: {
    nixosConfigurations = {
      htpc = flex-system {
        arch = "x86_64";
        version = "24.11";
        
        modules = [
          ./modules/common/networkmanager
          ./modules/common/pipewire
          ./modules/common/bluetooth
          ./modules/host/htpc
          ./modules/user/user
          steam-console.modules.default
          { ... }: {
            services = {
              roon-server = {
                enable = true;
                openFirewall = true;
              };
              desktopManager.plasma6.enable = true;
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
      thinkpad = flex-system {
        arch = "x86_64";
        version = "24.11";
        
        modules = [
          ./modules/common/networkmanager
          ./modules/common/pipewire
          ./modules/common/bluetooth
          ./modules/common/printing
          ./modules/host/thinkpad
          ./modules/user/user
        ]
      };
    };
  };
}
