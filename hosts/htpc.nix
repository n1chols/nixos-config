{ config, lib, pkgs, ... }: {

  # HOST NAME / TIME ZONE
  networking.hostName = "HTPC";
  time.timeZone = "America/Los_Angeles";
  
  # HARDWARE / DRIVERS
  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    xpadneo.enable = true;
  };

  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  # FILE SYSTEM
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

  # IMPORTS / MODULES
  imports = [
    ../bundles/gnome.nix
    ../bundles/steam.nix
    ../bundles/pegasus.nix
    ../bundles/kodi.nix
    ../bundles/myapps.nix
    ../modules/multilogin.nix
  ];

  modules.multilogin = {
    enable = true;
    sessions = [
      "${pkgs.gamescope}/bin/gamescope -W 3840 -H 2160 --fullscreen --backend drm --immediate-flips --rt -- sh -c 'steam -tenfoot -silent & ${pkgs.pegasus-frontend}/bin/pegasus-fe'"
      "${pkgs.cage}/bin/cage -s ${pkgs.kodi}/bin/kodi-standalone"
      "${pkgs.dbus}/bin/dbus-run-session env XDG_SESSION_TYPE=wayland ${pkgs.gnome-session}/bin/gnome-session"
      #"${pkgs.gamescope}/bin/gamescope --backend drm --immediate-flips --rt --steam -- ${pkgs.steam}/bin/steam -tenfoot -pipewire-dmabuf"
      #"${pkgs.cage}/bin/cage -s ${pkgs.pegasus-frontend}/bin/pegasus-fe"
    ];
  };

}
