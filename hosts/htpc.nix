{ config, pkgs, ... }: {

  # Hardware
  hardware = {
    cpu = "amd";
    gpu = "amd";
  };

  # Modules
  modules = {
    wireless.enable = true;
    audio.enable = true;
    desktop.enable = true;
    gaming.enable = true;
    web.enable = true;
    virtualization.enable = true;
  };

};
