{ config, lib, pkgs, ... }: {

  # Install Kodi
  #environment.systemPackages = with pkgs; [
  #  (kodi.withPackages (pkgs: with pkgs; [
  #    joystick
  #    inputstream-adaptive
  #  ]))
  #];

  services.xserver.desktopManager.kodi.package = (pkgs.kodi.withPackages (kodiPkgs: with kodiPkgs; [
    joystick
    inputstream-adaptive
  ]));

}
