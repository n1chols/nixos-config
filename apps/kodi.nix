{ config, lib, pkgs, ... }: {

  # Install Kodi
  environment.systemPackages = with pkgs; [
    (kodi.withPackages (p: with p; [
      p.joystick
    ]))
  ];

}
