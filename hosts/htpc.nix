{ config, pkgs, ... }: {

  # Modules
  imports = [
    ../modules/desktop.nix
  ];

  # Hostname
  networking.hostName = "BEDROOM_HTPC";

  # Hardware
  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
  };

  boot = {
    initrd.kernelModules = [ "amdgpu" ];
    kernelParams = [
      "amd_iommu=on"
      "iommu=pt"
      "vfio-pci.ids=10de:1234,10de:5678"
    ];
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

};
