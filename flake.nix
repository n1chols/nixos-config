{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    simple-system.url = "github:tob4n/nixos-simple-system";
  };

  outputs = { simple-system, ... }: {
    nixosConfigurations.htpc = simple-system.mkSystem {
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
        ./modules/pegasus-session.nix
        ./modules/roon-server.nix
        ./modules/kodi.nix
      ];
    };
  };
}
