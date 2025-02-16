{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    simple-system.url = "github:tob4n/nixos-simple-system";
  };

  outputs = { nixpkgs, simple-system, ... }: {
    nixosConfigurations.htpc = simple-system.nixosSystem {
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
        ./modules/gamescope.nix
        ./modules/steam.nix
        ./modules/kodi.nix
        ./modules/roon-server.nix
        ./modules/update-command.nix
        ({ pkgs, ... }: {
          environment.systemPackages = with pkgs; [
            pegasus-frontend
            bottles
            waydroid
            cemu
            ryujinx
          ];
          services.greetd = {
            enable = true;
            settings.default_session = {
              user = "user";
              command = "${pkgs.dbus}/bin/dbus-run-session env XDG_SESSION_TYPE=wayland ${pkgs.gnome-session}/bin/gnome-session";
              #command = "${pkgs.gamescope}/bin/gamescope -W 3840 -H 2160 --framerate-limit 120 --adaptive-sync --hdr-enabled --hdr-itm-enable -- sh -c '${pkgs.steam}/bin/steam -silent -nofriendsui & ${pkgs.pegasus-frontend}/bin/pegasus-fe' > /dev/null 2>&1";
            };
          };
        })
      ];
    };
  };
}
