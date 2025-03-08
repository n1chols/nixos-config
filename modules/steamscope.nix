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

  environment.systemPackages = let
    steamOverride = pkgs.steam.override {
      buildFHSEnv = pkgs.buildFHSEnv.override {
        bubblewrap = "${config.security.wrapperDir}/..";
      };
    };
  in [
    steamOverride
    (pkgs.writeShellScriptBin "steamscope" ''
      #!/bin/sh
      exec ${config.security.wrapperDir}/gamescope -f -e "$@" -- ${steamOverride}/bin/steam -gamepadui
    '')
  ];

}
