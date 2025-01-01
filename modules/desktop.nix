{ config, pkgs, ... }: {

  # Hyprland
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    displayManager.gdm.wayland = true;
  };

  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  users.users.user.extraGroups = [ "video" ];

  # Apps
  environment.systemPackages = with pkgs; [
    kitty
    waybar
    wofi
    mako
    libnotify
    wl-clipboard
    swaybg
    grim
    slurp
    pcmanfm
    gvfs
    zathura
    imv
    mpv
    zed
    firefox
    thunderbird
  ];

  xdg.mime.defaultApplications = {
    "x-scheme-handler/http" = "firefox.desktop";
    "x-scheme-handler/https" = "firefox.desktop";
    "x-scheme-handler/mailto" = "thunderbird.desktop";
    "inode/directory" = "pcmanfm.desktop";
    "application/pdf" = "org.pwmt.zathura.desktop";
    "image/*" = "imv.desktop";
    "video/*" = "mpv.desktop";
    "text/*" = "zed.desktop";
  };

};
