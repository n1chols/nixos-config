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

  boot.initrd.kernelModules = [ "amdgpu" ];

  services.xserver.videoDrivers = [ "amdgpu" ];

  # Optimization
  boot = {
    kernelParams = [ 
      "amd_pstate=active"
      "mitigations=off"
    ];
  };  

};
