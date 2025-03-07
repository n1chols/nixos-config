{ pkgs, ... }: {
  security.wrappers.gamescope-rt = {
    owner = "root";
    group = "root";
    capabilities = "cap_sys_nice+eip";
    source = "${pkgs.runCommand "gamescope-rt" {
      nativeBuildInputs = [ pkgs.makeBinaryWrapper ];
    } ''
      mkdir -p $out/bin
      cp ${pkgs.gamescope}/bin/gamescope $out/bin/gamescope-rt
      wrapProgram $out/bin/gamescope-rt --add-flags "--rt --immediate-flips"
    ''}/bin/gamescope-rt";
  };

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "gamescope-rt" ''
      exec /run/wrappers/bin/gamescope-rt "$@"
    '')
  ];
}
