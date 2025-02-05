{ config, lib, pkgs, ... }: {

  # Install Emulators
  environment.systemPackages = with pkgs; [
    bottles
    waydroid
    cemu
    ryujinx
  ];

}
