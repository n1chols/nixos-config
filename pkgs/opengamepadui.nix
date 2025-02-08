{ config, lib, pkgs, ... }: {

  # Install OpenGamepadUI
  environment.systemPackages = with pkgs; [
    opengamepadui
  ];

}
