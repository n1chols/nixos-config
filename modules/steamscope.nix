{ config, pkgs, ... }: {

  security.wrappers = {
    gamescope = {
      owner = "root";
      group = "root";
      source = "${pkgs.gamescope}/bin/gamescope";
      capabilities = "cap_sys_nice+eip";
    };
    bwrap = {
      owner = "root";
      group = "root";
      source = "${pkgs.bubblewrap}/bin/bwrap";
      setuid = true;
    };
  };

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "steamscope" ''
      #!/bin/sh
      exec ${config.security.wrapperDir}/gamescope -f -e "$@" -- ${(pkgs.steam.override { buildFHSEnv = pkgs.buildFHSEnv.override { bubblewrap = "${config.security.wrapperDir}/.."; }; })}/bin/steam -gamepadui > /dev/null 2>&1
    '')
  ];

}
