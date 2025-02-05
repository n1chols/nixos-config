{ config, lib, pkgs, ... }: {

  # Install git
  environment.systemPackages = with pkgs; [
    git
  ];

  # Add shell command
  environment.shellAliases = {
    "reconfig" = ''
      sudo git clone --force https://github.com/tob4n/nixos-config /etc/nixos || \
      (cd /etc/nixos && sudo git pull) && \
      sudo nixos-rebuild switch
    '';
  };
  
}
