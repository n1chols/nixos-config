{ config, pkgs, ... }: {

  # Modules
  imports = [
    ../module/audio.nix
    ../module/bluetooth.nix
    ../modules/desktop.nix
    ../modules/development.nix
    ../modules/gaming.nix
  ];

  # Hostname
  networking.hostName = "BEDROOM_HTPC";

  # Hardware
  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
  };

  boot.initrd.kernelModules = [ "amdgpu" ];

  services.xserver.videoDrivers = [ "amdgpu" ];

}
