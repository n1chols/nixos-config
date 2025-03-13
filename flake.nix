{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    simple-system.url = "github:n1chols/nixos-simple-system";
    steam-console.url = "github:n1chols/nixos-steam-console";
  };

  outputs = { simple-system, steam-console, ... }: {
    nixosConfigurations.htpc = simple-system {
      hostName = "htpc";
      userName = "user";

      cpuVendor = "amd";
      gpuVendor = "amd";

      bootDevice = "/dev/nvme0n1p1";
      rootDevice = "/dev/nvme0n1p2";
      swapDevice = "/dev/nvme0n1p3";

      hiResAudio = true;
      gamingTweaks = true;
      gamepad = true;

      modules = [
        ./modules/plasma-bigscreen.nix
        ./modules/roon-server.nix
        ./modules/bombsquad.nix
        ./modules/update-command.nix
        steam-console.nixosModules.default
        ({ pkgs, ... }: {
          steam-console = {
            enable = true;
            enableHDR = true;
            enableVRR = true;
            enableDecky = true;
            user = "user";
            desktopSession = "plasma-bigscreen";
          };
        })
      ];
    };
  };
}
