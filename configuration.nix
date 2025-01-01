{ config, pkgs, ... }: {

  # Host
  imports = [
    # Replace with your host config (e.g., hosts/thinkpad.nix)
    ./hosts/example.nix
  ];

  # Boot
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
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
  
  # User
  users.users.user = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

};
