{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    simple-system.url = "github:tob4n/nixos-simple-system";
  };

  outputs = { nixpkgs, simple-system, ... }: {
    nixosConfigurations.htpc = simple-system.outputs.mkSystem {
      hostName = "htpc";
      userName = "user";

      cpuVendor = "amd";
      gpuVendor = "amd";

      bootDevice = "/dev/nvme0n1p1";
      rootDevice = "/dev/nvme0n1p2";
      swapDevice = "/dev/nvme0n1p3";

      gamingTweaks = true;
      hiResAudio = true;

      extraModules = [
        ./modules/gamescope.nix
        ./modules/steam.nix
        ./modules/kodi.nix
        ./modules/roon-server.nix
        ./modules/update-command.nix
        ({ pkgs, ... }: {
          environment.systemPackages = [ pkgs.pegasus-frontend ];
          services.greetd = {
            enable = true;
            settings.default_session = {
              user = "user";
              command = "gamescope -W 3840 -H 2160 -r 120 --adaptive-sync --hdr-enabled --hdr-itm-enable -- sh -c 'steam -silent -nofriendsui & pegasus-fe'";
            };
          };
        })
      ];
    };
  };
}
