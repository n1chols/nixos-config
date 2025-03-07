{ pkgs, ... }: {
  gamescope-rt-base = pkgs.runCommand "gamescope-rt-base" {
    nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
  } ''
    mkdir -p $out/bin
    cp ${pkgs.gamescope}/bin/gamescope $out/bin/gamescope-rt
    wrapProgram $out/bin/gamescope-rt --add-flags "--rt --immediate-flips --backend drm"
  '';

  security.wrappers.gamescope-rt = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_nice+eip";
    source = "${pkgs.gamescope-rt-base}/bin/gamescope-rt";
  };

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "gamescope-rt" ''
      exec /run/wrappers/bin/gamescope-rt "$@"
    '')
  ];
}
