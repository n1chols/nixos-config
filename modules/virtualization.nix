{ config, pkgs, ... }: {

  # QEMU
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      ovmf.enable = true;
      swtpm.enable = true;
    };
  };

  users.users.user.extraGroups = [ "libvirtd" ];
  
  # VFIO
  boot.kernelModules = [ "vfio_pci" "vfio" "vfio_iommu_type1" ];

  # Virtual Machine Manager
  environment.systemPackages = with pkgs; [
    virt-manager
    win-virtio
  ];

};
