[ config, pkgs, ... ]: {

  imports = [
    #"./core/boot.nix"
    #"./core/hardware.nix"
    #"./core/network.nix"
    #"./core/time.nix"
    #"./core/localization.nix"
    #"./core/user.nix"
    #"./extra/audio.nix"
    "./extra/virtualization.nix"
    "./extra/hyprland.nix"
    "./extra/steam.nix"
    "./extra/chromium.nix"
  ];

  # Boot
  boot = {
    loader = {
      systemd-boot-enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelParams = [
      "amd_iommu=on"
    ];
    kernelPackages = linuxPackages_zen;
  }:

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
    hostname = "nixos";
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
