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
        ./modules/steam.nix
        ./modules/kodi.nix
        ./modules/roon-server.nix
        ./modules/update-command.nix
        ({ pkgs, config, ... }: {
          security.wrappers = {
            bwrap = {
              owner = "root";
              group = "root";
              source = "${pkgs.bubblewrap}/bin/bwrap";
              setuid = true;
            };
            gamescope = {
              owner = "root";
              group = "root";
              source = "${pkgs.gamescope}/bin/gamescope";
              capabilities = "cap_sys_nice+eip";
            };
          };
          environment.systemPackages = [
            (pkgs.steam.override {
              buildFHSEnv = pkgs.buildFHSEnv.override {
                bubblewrap = "${config.security.wrapperDir}/..";
              };
            })
          ];
          services.greetd = {
            enable = true;
            settings.default_session = {
              user = "user";
              command = "gamescope -f -e --backend drm --rt -- ${pkgs.steam}/bin/steam -gamepadui";# -pipewire-dmabuf";# > /dev/null 2>&1";
            };
          };
        })
      ];
    };
  };
}
