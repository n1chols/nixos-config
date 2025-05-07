{
  inputs = {
    shaved-ice.url = "github:n1chols/shaved-ice";
    cold-steamos.url = "github:n1chols/cold-steamos";
  };

  outputs = { shaved-ice, cold-steamos }: {
    nixosConfigurations.htpc = shaved-ice.system {
      arch = "x86_64";
      version = "24.11";
      
      hostname = "HTPC";
      timezone = "America/Los_Angeles";
      
      filesystem = {
        boot.device = "/dev/nvme0n1p1";
        root.device = "/dev/nvme0n1p2";
        swap = [{ device = "/dev/nvme0n1p3"; }]
      };
      
      modules = [
        shaved-ice.modules.grub
        shaved-ice.modules.networkmanager
        shaved-ice.modules.pipewire
        shaved-ice.modules.bluetooth
        cold-steamos.modules.default
        { ... }: {
          boot = {
            kernelPackages = pkgs.linuxPackages_zen;
            initrd.kernelModules = [ "amdgpu" ];
          };

          hardware = {
            cpu.amd.updateMicrocode = true;
            xpadneo.enable = true;
          };

          users.users.user = {
            isNormalUser = true;
            extraGroups = [ "networkmanager" "wheel" ];
          };

          services = {
            roon-server = {
              enable = true;
              openFirewall = true;
            };
            desktopManager.plasma6.enable = true;
          };

          cold-steamos = {
            enable = true;
            enableHDR = true;
            enableVRR = true;
            enableDecky = true;
            user = "user";
            desktopSession = "startplasma-wayland";
          }
        }
      ];
    };
  };
}
