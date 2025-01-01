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
    kernelParams = [ "amd_iommu=on" ];
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

};
