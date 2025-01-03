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
    xpadneo.enable = true;
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

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
    ../modules/steam.nix
    ../modules/kodi.nix
    ../modules/myapps.nix
  ];

  modules = {
    gnome.enable = true;
    steam.enable = true;
    kodi.enable = true;
    myapps = {
      enable = true;
      systemApps = true;
    };
    autotty = {
      enable = true;
    };
  };

  # Special HTPC setup
  services.getty.autologinUser = "user";

  environment.loginShellInit = "
    if [ -z \"$DISPLAY\" ] && [ \"$XDG_VTNR\" = 1 ]; then
      export XDG_SESSION_TYPE=wayland
      export XDG_CURRENT_DESKTOP=GNOME
      exec dbus-run-session gnome-session
    fi
  ";

}
