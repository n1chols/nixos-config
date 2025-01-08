{ config, lib, pkgs, ... }: {

  # Install Kodi with joystick package
  environment.systemPackages = with pkgs; [
    (kodi.withPackages (p: [ p.joystick ]))
  ];

}
