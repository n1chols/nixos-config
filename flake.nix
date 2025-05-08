{
  inputs = {
    flex-system.url = "github:n1chols/nixos-flex-system";
    steam-console.url = "github:n1chols/nixos-steam-console";
  };

  outputs = { shaved-ice, cold-steamos }: {
    nixosConfigurations.htpc = flex-system {
      arch = "x86_64";
      version = "24.11";
      
      modules = [
        cold-steamos.modules.default
        { ... }: {
          fileSystem = {
            "/boot".device = "/dev/nvme0n1p1";
            "/".device = "/dev/nvme0n1p2";
            swapDevices = [{ device = "/dev/nvme0n1p3"; }]
          };

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
