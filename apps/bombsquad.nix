{ config, lib, pkgs, ... }: {

  # Install BombSquad with hash override
  environment.systemPackages = with pkgs; [
    (stdenv.mkDerivation rec {
      name = "bombsquad";
      src = fetchurl {
        url = "https://files.ballistica.net/bombsquad/builds/BombSquad_Linux_x86_64_1.7.37.tar.gz";
        sha256 = lib.mkForce "rDbPq/hH40iA57D4vlFX+1heF4USlGCv24IiQDgOdEg=";
      };
    })
  ];

}
