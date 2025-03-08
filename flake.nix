{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    simple-system.url = "github:n1chols/nixos-simple-system";
  };

  outputs = { nixpkgs, simple-system, ... }: {
    nixosConfigurations.htpc = simple-system {
      hostName = "htpc";
      userName = "user";

      cpuVendor = "amd";
      gpuVendor = "amd";

      bootDevice = "/dev/nvme0n1p1";
      rootDevice = "/dev/nvme0n1p2";
      swapDevice = "/dev/nvme0n1p3";

      gamingTweaks = true;
      hiResAudio = true;
      gamepad = true;

      extraModules = [
        #./modules/steam.nix
        ./modules/kodi.nix
        ./modules/roon-server.nix
        ./modules/update-command.nix
        ({ pkgs, config, ... }: {
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
          steamWithFHS = pkgs.steam.override {
            buildFHSEnv = pkgs.buildFHSEnv.override {
              bubblewrap = "${config.security.wrapperDir}/..";
            };
          };
          services.greetd = {
            enable = true;
            settings.default_session = {
              user = "user";
              command = "${config.security.wrapperDir}/gamescope -f -e --rt --immediate-flips --adaptive-sync --hdr-enabled --hdr-itm-enable -- ${config.steamWithFHS}/bin/steam -gamepadui -pipewire-dmabuf";# > /dev/null 2>&1";
            };
          };
        })
      ];
    };
  };
}
