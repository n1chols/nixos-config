{ config, pkgs, ... }: {

  # Modules
  imports = [
    ../modules/desktop.nix
  ];

  # Hostname
  networking.hostName = "LENOVO_THINKPAD_X230";

  # Hardware
  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
  };

  boot = {
    initrd.kernelModules = [ "intel_agp" "i915" ];
    kernelParams = [ "intel_iommu=on" ];
  };

  services.xserver.videoDrivers = [ "intel" ];

};
