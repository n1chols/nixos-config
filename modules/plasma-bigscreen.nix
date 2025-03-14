{ pkgs, ... }: {

  boot.kernelPackages = pkgs.linuxPackages;

  services.xserver.enable = true;

  services.xserver.displayManager.sddm.wayland.enable = true;

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
      export GTK_USE_PORTAL=0
      
      rm -rf /run/user/1000/doc
      dbus-run session startplasma-wayland
      #${pkgs.dbus}/bin/dbus-run-session \
      #${pkgs.kdePackages.kwin}/bin/kwin_wayland \
      #"${pkgs.kdePackages.plasma-workspace}/bin/plasmashell" #-p org.kde.plasma.bigscreen"
    '')
  ];

}
