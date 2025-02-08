{ config, lib, pkgs, ... }: {

  # HOST NAME / TIME ZONE
  networking.hostName = "HTPC";
  time.timeZone = "America/Los_Angeles";
  
  # HARDWARE / DRIVERS
  nixpkgs.hostPlatform = "x86_64-linux";

  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
    graphics = {
      enable = true;
      enable32Bit = true;
    };
    xpadneo.enable = true;
  };

  boot = {
    initrd.kernelModules = [ "amdgpu" ];
    kernelPackages = pkgs.linuxPackages_xanmod;
    kernelParams = [
      "amd_pstate=active"
      "mitigations=off"
    ];
  };

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

  # PACKAGES / UTILITIES
  imports = [
    ../../pkgs/update-command.nix
    ../../pkgs/hyprland.nix
    ../../pkgs/pegasus.nix
    ../../pkgs/steam.nix
    ../../pkgs/kodi.nix
    ../../pkgs/bombsquad.nix
    ../../pkgs/roon-server.nix
    ../../utils/apps.nix
    ../../utils/sessions.nix
  ];

  modules = {
    apps = {
      enable = true;
      emulators = true;
    };
    sessions = {
      enable = true;
      commands = [
        "${pkgs.dbus}/bin/dbus-run-session env XDG_SESSION_TYPE=wayland ${pkgs.hyprland}/bin/Hyprland"
        "env STEAM_GAMESCOPE_VRR_SUPPORTED=1 STEAM_GAMESCOPE_HDR_SUPPORTED=1 STEAM_GAMESCOPE_FANCY_SCALING_SUPPORT=1 ${pkgs.gamescope}/bin/gamescope -W 3840 -H 2160 -r 120 --adaptive-sync --hdr-enabled --hdr-itm-enable --steam -- ${pkgs.steam}/bin/steam -tenfoot"
      ];
    };
  };

}
