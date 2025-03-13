{ config, lib, pkgs, ... }: {

  # Install Kodi
  environment.systemPackages = with pkgs; [
    cage
    (kodi.withPackages (pkgs: with pkgs; [
      joystick
      inputstream-adaptive
    ]))
  ];

}
