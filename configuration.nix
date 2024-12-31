[ config, pkgs, ... ]: {

  imports = [
    # Necessary configs
    "./core/boot.nix"
    "./core/hardware.nix"
    "./core/time.nix"
    "./core/localization.nix"
    "./core/user.nix"

    # Optional services
    "./service/network.nix"
    "./service/audio.nix"

    # Optional features
    "./extra/virtualization.nix"
    "./extra/hyprland.nix"
    "./extra/browser.nix"
    "./extra/steam.nix"
  ];

  system.stateVersion = "24.11";

  # Boot
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [
      "amd_iommu=on"
    ];
    kernelPackages = linuxPackages_zen;
  };

  # Hardware
  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    xpadneo.enable = true;
  };

  # Network
  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  # Time
  time = {
    timeZone = "America/Los_Angeles";
    hardwareClockInLocalTime = true;
  };

  # Localization
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

};
