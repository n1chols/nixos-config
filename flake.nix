{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    simple-system.url = "github:n1chols/nixos-simple-system";
  };

  outputs = { nixpkgs, simple-system, ... }: {
    nixosConfigurations.htpc = simple-system {
      hostName = "htpc";
      userName = "user";

      cpuVendor = "amd";
      gpuVendor = "amd";

      bootDevice = "/dev/nvme0n1p1";
      rootDevice = "/dev/nvme0n1p2";
      swapDevice = "/dev/nvme0n1p3";

      gamingTweaks = true;
      hiResAudio = true;
      gamepad = true;

      extraModules = [
        ./modules/steamscope.nix
        ./modules/kodi.nix
        ./modules/roon-server.nix
        ./modules/update-command.nix
        ({ pkgs, config, ... }: {
          services.greetd = {
            enable = true;
            settings.default_session = {
              user = "user";
              command = "steamscope --adaptive-sync --hdr-enabled --hdr-itm-enable";
            };
          };
        })
      ];
    };
  };
}
