{ config, pkgs, ... }: {

  # Packages
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    bash
    python3
    deno
  ];

}
