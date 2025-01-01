{ config, pkgs, ... }: {

  # Hostname
  networking.hostName = "BEDROOM_HTPC";

  # Hardware
  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
  };

  boot.initrd.kernelModules = [ "amdgpu" ];

  services.xserver.videoDrivers = [ "amdgpu" ];

  # Optimization
  boot = {
    kernelParams = [ 
      "amd_pstate=active"
      "mitigations=off"
    ];
  };  

  # Modules
  modules = {
    desktop.enable = true;
    apps.enable = true;
    virtualization.enable = true;
  };

};
