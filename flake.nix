{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    simple-system.url = "github:n1chols/nixos-simple-system";
    steam-console.url = "github:n1chols/nixos-steam-console";
  };

  outputs = { simple-system, ... }: {
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

      modules = [
        ./modules/kodi.nix
        ./modules/roon-server.nix
        ./modules/update-command.nix
        ({ ... }: {
          steam-console = {
            enable = true;
            enableDecky = true;
            user = "user"
            desktopSession = "dbus-run-session -- gnome-shell --display-server --wayland"
          }
        })
      ];
    };
  };
}
