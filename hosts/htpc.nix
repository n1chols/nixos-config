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
    ../modules/es-de.nix
    ../modules/kodi.nix
    ../modules/myapps.nix
    ../modules/multilogin.nix
  ];

  modules = {
    gnome.enable = true;
    steam.enable = true;
    es-de.enable = true;
    kodi.enable = true;
    myapps.enable = true;
    multilogin = {
      enable = true;
      sessions = [
        "XDG_SESSION_TYPE=wayland ${pkgs.gnome.gnome-session}/bin/gnome-session"
        "${pkgs.gamescope}/bin/gamescope --steam -- ${pkgs.steam}/bin/steam -tenfoot -pipewire-dmabuf"
        "${pkgs.cage}/bin/cage -s ${pkgs.emulationstation-de}/bin/es-de"
        "${pkgs.cage}/bin/cage -s ${pkgs.kodi}/bin/kodi-standalone"
      ];
    };
  };

}
