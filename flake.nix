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

      animateStartup = false;
      gamingTweaks = true;
      hiResAudio = true;
      gamepad = true;

      modules = [
        ./modules/gnome.nix
        ./modules/kodi.nix
        ./modules/roon-server.nix
        ./modules/update-command.nix
        ./modules/bombsquad.nix
        steam-console.nixosModules.default
        ({ pkgs, ... }: {
          steam-console = {
            enable = true;
            enableHDR = true;
            enableVRR = true;
            enableDecky = true;
            user = "user";
            desktopSession = "${pkgs.cage}/bin/cage -s ${pkgs.kodi}/bin/kodi";
          };
        })
      ];
    };
  };
}
