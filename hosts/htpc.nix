{ config, pkgs, ... }: {

  # Drivers
  boot = {
    initrd.kernelModules = [ "amdgpu" ];
    kernelModules = [ "kvm-amd" ];
    kernelParams = [ "amd_iommu=on" ];
  };

  hardware.opengl.extraPackages = with pkgs; [
    rocm-opencl-icd
    rocm-opencl-runtime
    amdvlk
  ];

  services.xserver.videoDrivers = [ "amdgpu" ];

  services.hardware.corectrl.enable = true;

  # Optimization
  powerManagement.cpuFreqGovernor = "performance";

  boot.kernel.sysctl = {
    "vm.swappiness" = 10;
    "vm.vfs_cache_pressure" = 50;
  };

};
