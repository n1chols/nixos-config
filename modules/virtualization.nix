{ config, pkgs, ... }: {

  # QEMU
  boot.kernelParams = [ "amd_iommu=on" ];

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      ovmf.enable = true;
      swtpm.enable = true;
    };
  };

  users.users.user.extraGroups = [ "libvirtd" ];

  # Looking Glass
  environment.systemPackages = with pkgs; [
    looking-glass-client
    virt-manager
    win-virtio
  ];

};
