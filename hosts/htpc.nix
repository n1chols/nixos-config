{ config, pkgs, ... }: {

  # Hardware
  hardware = {
    cpu = "amd";
    gpu = "amd";
  };

  # Drivers
  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
  ];

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
