{ ... }: {
  # Enable printing service
  services.printing.enable = true;

  # Enable printer autodiscovery
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
}
