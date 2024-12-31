{ config, pkgs, ... }: {

  # RTKit
  security.rtkit.enable = true;

  # Pipewire
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

}
