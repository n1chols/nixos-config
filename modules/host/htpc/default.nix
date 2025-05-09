{ 
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
}
