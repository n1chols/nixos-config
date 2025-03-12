{ config, lib, pkgs, ... }: {

  # Install BombSquad 1.7.37
  environment.systemPackages = with pkgs; [
    (pkgs.bombsquad.overrideAttrs (oldAttrs: rec {
      src = pkgs.fetchurl {
        url = "https://files.ballistica.net/bombsquad/builds/old/BombSquad_Linux_x86_64_1.7.37.tar.gz";
        sha256 = "rDbPq/hH40iA57D4vlFX+1heF4USlGCv24IiQDgOdEg=";
      };
    }))
  ];

}
