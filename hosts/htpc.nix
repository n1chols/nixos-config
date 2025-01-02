{ config, pkgs, ... }: {

  # Host name
  networking.hostName = "HTPC";

  # Time zone
  time.timeZone = "America/Los_Angeles";
  
  # Hardware setup
  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
    steam-hardware.enable = true;
    xpadneo.enable = true;
    video.hidpi.enable = true;
  };

  services.xserver = {
    videoDrivers = [ "amdgpu" ];
    displayManager.gdm.autoSuspend = false;
  };

  boot.initrd.kernelModules = [ "amdgpu" ];

  # File systems
  fileSystems = {
    "/" = {
      device = "/dev/nvme0n1p2";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/nvme0n1p1";
      fsType = "vfat";
    };
  };

  swapDevices = [
    { device = "/dev/nvme0n1p3"; }
  ];

  # Modules configuration
  imports = [
    ../modules/gnome.nix
    ../modules/myapps.nix
    ../modules/steam.nix
    ../modules/kodi.nix
  ];

  modules = {
    gnome = {
      enable = true;
      disableCoreApps = true;
      disablePowerManager = true;
    };
    myapps = {
      enable = true;
      systemApps = true;
    };
    steam = {
      enable = true;
      addSessionEntry = true;
    };
    kodi = {
      enable = true;
      addSessionEntry = true;
    };
  };

}
