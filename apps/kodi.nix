{ config, lib, pkgs, ... }: {

  # Install Kodi
  environment.systemPackages = with pkgs; [
    (kodi.withPackages (pkgs: with pkgs; [
      joystick
      inputstream-adaptive
    ]))
  ];

}
