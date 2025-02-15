{
  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  inputs.easy-pc.url = "github:tob4n/nixos-easy-pc";

  outputs = { easy-pc, ... }: {
    nixosConfigurations.htpc = easy-pc.mkSystem {
      hostName = "htpc";
      userName = "user";
      cpuVendor = "amd";
      gpuVendor = "amd";
      bootDevice = "/dev/nvme0n1p1";
      rootDevice = "/dev/nvme0n1p2";
      swapDevice = "/dev/nvme0n1p3";
      gamingTweaks = true;
      hiResAudio = true;
    };
  };
}
