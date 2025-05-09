{ pkgs, ... }: {
  networking.hostName = "HTPC";

  time.timeZone = "America/Los_Angeles";

  fileSystems = {
    "/boot".device = "/dev/nvme0n1p1";
    "/".device = "/dev/nvme0n1p2";
  };

  swapDevices = [{ device = "/dev/nvme0n1p3"; }];

  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    initrd.kernelModules = [ "amdgpu" ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  hardware = {
    cpu.amd.updateMicrocode = true;
    xpadneo.enable = true;
  };
}
