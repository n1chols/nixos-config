{ config, lib, pkgs, ... }: {

  # Install BombSquad
  environment.systemPackages = with pkgs; [
    bombsquad
  ];

  # Hash fix until nixpkgs gets updated
  pkgs.bombsquad = pkgs.stdenv.mkDerivation rec {
    name = "bombsquad-1.7.37";
    src = pkgs.fetchurl {
      url = "https://files.ballistica.net/bombsquad/builds/BombSquad_Linux_x86_64_1.7.37.tar.gz";
      sha256 = "rDbPq/hH40iA57D4vlFX+1heF4USlGCv24IiQDgOdEg=";
    };
  };

}
