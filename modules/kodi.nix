{ config, lib, pkgs, ... }: {

  # Install Kodi
  environment.systemPackages = with pkgs; [
    stremio
    (kodi.withPackages (pkgs: with pkgs; [
      joystick
      inputstream-adaptive
    ]))
  ];

}
