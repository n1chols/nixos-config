{ config, lib, pkgs, ... }: {

  # Install BombSquad 1.7.37
  environment.systemPackages = with pkgs; [
    (pkgs.bombsquad.overrideAttrs (oldAttrs: rec {
      src = pkgs.fetchurl {
        url = "https://files.ballistica.net/bombsquad/builds/BombSquad_Linux_x86_64_1.7.38.tar.gz";
        sha256 = "9564c3fda8e4e03142de6ee3b79e0fb2497fe678aedeca0b74762a4e27b75294";
      };
    }))
  ];

}
