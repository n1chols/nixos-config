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

  # Modules
  modules = {
    wireless.enable = true;
    audio.enable = true;
    desktop.enable = true;
    gaming.enable = true;
    web.enable = true;
    virtualization.enable = true;
  };

};
