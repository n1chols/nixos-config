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
    {
      device = "/dev/nvme0n1p3";
    }
  ];

  # IMPORTS / MODULES
  imports = [
    ../pkgs/hyprland.nix
    ../pkgs/pegasus.nix
    ../pkgs/es-de.nix
    ../pkgs/steam.nix
    ../pkgs/kodi.nix
    ../pkgs/bombsquad.nix
    ../pkgs/emulators.nix
    ../modules/update.nix
    ../modules/sessions.nix
  ];

  modules = {
    update = {
      enable = true;
      repo = "https://github.com/tob4n/nixos-config";
    };
    sessions = {
      enable = true;
      commands = [
        "${pkgs.gamescope}/bin/gamescope -w 3840 -h 2160 -r 120 --backend drm --immediate-flips --rt --fullscreen --adaptive-sync --hdr-enabled --hdr-itm-enable -- sh -c '${pkgs.steam}/bin/steam -silent & ${pkgs.pegasus-frontend}/bin/pegasus-fe'"
        "${pkgs.gamescope}/bin/gamescope -w 3840 -h 2160 -r 120 --backend drm --immediate-flips --rt --fullscreen --adaptive-sync --hdr-enabled --hdr-itm-enable -- sh -c 'emulationstation-de'"
        "${pkgs.hyprland}/bin/hyprland"
      ];
    };
  };

}
