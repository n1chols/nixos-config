{ pkgs, ... }: {
  
  services.xserver.desktopManager.plasma5 = {
    enable = true;
    bigscreen.enable = true;
    useQtScaling = true;
  };

  environment.systemPackages = [
    pkgs.writeScriptBin "plasma-bigscreen" ''
      #!/bin/sh
      export QT_QPA_PLATFORM=wayland
      ${pkgs.dbus}/bin/dbus-run-session \
      ${pkgs.plasma5Packages.kwin}/bin/kwin_wayland \
      "${pkgs.plasma5Packages.plasma-workspace}/bin/plasmashell -p org.kde.plasma.bigscreen"
    '';
  ];

}
