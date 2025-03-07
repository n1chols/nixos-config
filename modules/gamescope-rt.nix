{ pkgs }: {
  environment.systemPackages = with pkgs; [
    (symlinkJoin {
      name = "gamescope-rt";
      paths = [ gamescope ];
      nativeBuildInputs = [ makeBinaryWrapper libcap ];
      postBuild = ''
        wrapProgram $out/bin/gamescope --add-flags "--rt --immediate-flips --backend drm"
        mv $out/bin/gamescope $out/bin/gamescope-rt
        setcap cap_sys_nice+eip $out/bin/gamescope-rt
      '';
    })
  ];
}
