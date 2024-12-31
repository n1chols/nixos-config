{ config, pkgs, ... }: {

  # Qemu
  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      ovmf.enable = true;
      swtpm.enable = true;
    };
  };

  users.users.user.extraGroups = [ "libvirtd" ];

}
