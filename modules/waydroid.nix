{ config, lib, pkgs, ... }: {

  # Enable Waydroid
  virtualisation.waydroid.enable = true;

  systemd.services.waydroid-container.wantedBy = [ "multi-user.target" ];

}
