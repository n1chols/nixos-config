{ pkgs }: {
  environment.systemPackages = with pkgs; [
    (runCommand "gamescope-rt" {
      nativeBuildInputs = [ makeBinaryWrapper libcap ];
    } ''
      mkdir -p $out/bin
      cp ${gamescope}/bin/gamescope $out/bin/gamescope-rt
      wrapProgram $out/bin/gamescope-rt --add-flags "--rt --immediate-flips --backend drm"
      setcap cap_sys_nice+eip $out/bin/gamescope-rt
    '')
  ];
}
