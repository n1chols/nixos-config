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
    ../modules/myapps.nix
    ../modules/steam.nix
    ../modules/kodi.nix
  ];

  modules = {
    gnome = {
      enable = true;
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

  # Special HTPC setup
  services.getty = {
    autologinUser = "user";
    extraArgs = [ "--noclear" ];
  };

  programs.bash.loginShellInit = ''
    if [ "$(tty)" = "/dev/tty1" ]; then
      exec startx /usr/share/xsessions/gnome.desktop
    elif [ "$(tty)" = "/dev/tty2" ]; then
      exec startx /usr/share/xsessions/gamescope.desktop
    elif [ "$(tty)" = "/dev/tty3" ]; then
      exec startx /usr/share/xsessions/kodi.desktop
    fi
  '';

}
