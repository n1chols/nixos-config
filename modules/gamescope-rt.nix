{ pkgs }:

let
  gamescope-rt = pkgs.runCommand "gamescope-rt" {
    nativeBuildInputs = [ pkgs.makeBinaryWrapper pkgs.libcap ];
  } ''
    mkdir -p $out/bin
    cp ${pkgs.gamescope}/bin/gamescope $out/bin/gamescope-rt
    wrapProgram $out/bin/gamescope-rt --add-flags "--rt --immediate-flips --backend drm"
    setcap "cap_sys_nice+eip" $out/bin/gamescope-rt
  '';
in
{
  environment.systemPackages = [ gamescope-rt ];
}
