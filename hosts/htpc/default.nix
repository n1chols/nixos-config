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
        "${pkgs.gamescope}/bin/gamescope -W 3840 -H 2160 -r 120 --adaptive-sync --hdr-enabled --hdr-itm-enable -- sh -c '${pkgs.steam}/bin/steam -no-browser +open steam://open/bigpicture -fulldesktopres -noforcemaccel -noforcemparms -noforcemspd & ${pkgs.pegasus-frontend}/bin/pegasus-fe'"
      ];
    };
  };

}
