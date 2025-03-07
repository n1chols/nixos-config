{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    simple-system.url = "github:tob4n/nixos-simple-system";
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
        ({ pkgs, ... }: {
          environment.systemPackages = [
            pkgs.gamescope
          ];
          security.pam.loginLimits = [
            {
              domain = "user";
              type = "-";
              item = "rtprio";
              value = "95";
            }
            {
              domain = "user";
              type = "-";
              item = "nice";
              value = "-20";
            }
          ];
          services.greetd = {
            enable = true;
            settings.default_session = {
              user = "user";
              command = "${pkgs.gamescope}/bin/gamescope -f -e --backend drm --rt -- ${pkgs.steam}/bin/steam -gamepadui";# -pipewire-dmabuf";# > /dev/null 2>&1";
            };
          };
        })
      ];
    };
  };
}
