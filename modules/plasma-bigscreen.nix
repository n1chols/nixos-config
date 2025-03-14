{ pkgs, ... }: {

  boot.kernelPackages = pkgs.linuxPackages_6_11;
  boot.kernelParams = [ "amdgpu.sg_display=0" ];

  services.xserver.enable = true;

  services.displayManager.sddm.wayland.enable = true;

  services.desktopManager.plasma6.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
  };

  programs.dconf.enable = true;
  
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };

  environment.systemPackages = with pkgs; [
    pkgs.fuse3
    (pkgs.writeScriptBin "plasma-bigscreen" ''
      #!/bin/sh
      export QT_QPA_PLATFORM=wayland
      startplasma-wayland
      #${pkgs.dbus}/bin/dbus-run-session \
      #${pkgs.kdePackages.kwin}/bin/kwin_wayland \
      #"${pkgs.kdePackages.plasma-workspace}/bin/plasmashell" #-p org.kde.plasma.bigscreen"
    '')
  ];

}
