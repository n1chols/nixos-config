{ config, lib, pkgs, ... }: {

  # Install Emulators
  environment.systemPackages = with pkgs; [
    bottles
    cemu
    ryujinx
  ];

}
