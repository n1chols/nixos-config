{ config, pkgs, ... }: {

  # Modules
  imports = [
    ../module/audio.nix
    ../module/bluetooth.nix
    ../modules/desktop.nix
    ../modules/development.nix
  ];

  # Hostname
  networking.hostName = "LENOVO_THINKPAD_X230";

  # Hardware
  hardware = {
    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;
  };

  boot.initrd.kernelModules = [ "intel_agp" "i915" ];

  services.xserver.videoDrivers = [ "intel" ];

}
