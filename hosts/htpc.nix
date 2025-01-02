{ config, pkgs, ... }: {

  # Host name
  networking.hostName = "HTPC";

  # Time zone
  time.timeZone = "America/Los_Angeles";
  
  # Hardware setup
  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    steam-hardware.enable = true;
    xpadneo.enable = true;
  };

  boot.initrd.kernelModules = [ "amdgpu" ];

  services.xserver = {
    videoDrivers = [ "amdgpu" ];
    displayManager.gdm.autoSuspend = false;
    dpi = "120";
  };

  environment.sessionVariables = {
    GDK_SCALE = "2";
    GDK_DPI_SCALE = "0.5";
  };

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
