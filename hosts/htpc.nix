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
    ../modules/greetd.nix
  ];

  modules = {
    gnome.enable = true;
    steam.enable = true;
    kodi.enable = true;
    myapps = {
      enable = true;
      systemApps = true;
    };
    greetd = {
      enable = true;
      sessions = {
        gnome = "dbus-run-session ${pkgs.gnome-session}/bin/gnome-session";
        steam = "${pkgs.gamescope}/bin/gamescope -- ${pkgs.steam}/bin/steam -tenfoot -pipewire-dmabuf";
        kodi = "LIRC_SOCKET_PATH=/run/lirc/lircd ${pkgs.kodi}/bin/kodi --standalone";
      };
    };
  };

}
