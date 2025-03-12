{ config, lib, pkgs, ... }: {

  # Install BombSquad 1.7.37
  environment.systemPackages = with pkgs; [
    (pkgs.bombsquad.overrideAttrs (oldAttrs: rec {
      src = pkgs.fetchurl {
        url = "https://files.ballistica.net/bombsquad/builds/old/BombSquad_Linux_x86_64_1.7.37.tar.gz";
        sha256 = "83dadb1f8df51dac37baf793e8eea1cd8f47858c8c63a793c0065f4e542f9839";
      };
    }))
  ];

}
