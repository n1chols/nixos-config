{ pkgs, ... }: {
  
  services.xserver.desktopManager.plasma5 = {
    enable = true;
    bigscreen.enable = true;
    useQtScaling = true;
  };

  environment.systemPackages = [
    pkgs.writeScriptBin "plasma-bigscreen" ''
      QT_QPA_PLATFORM=wayland dbus-run-session kwin_wayland "plasmashell -p org.kde.plasma.bigscreen"
    '';
  ];

}
