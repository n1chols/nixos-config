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

  steamOverride = pkgs.steam.override {
    buildFHSEnv = pkgs.buildFHSEnv.override {
      bubblewrap = "${config.security.wrapperDir}/..";
    };
  };

  environment.systemPackages = [
    (pkgs.writeShellScriptBin "steamscope" ''
      #!/bin/sh
      exec ${config.security.wrapperDir}/gamescope -f -e --rt --immediate-flips "$@" -- ${config.steamOverride}/bin/steam -gamepadui -pipewire-dmabuf
    '')
  ];
}
