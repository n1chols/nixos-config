{ pkgs, ... }: {

  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs; [
    (pkgs.writeScriptBin "plasma-bigscreen" ''
      #!/bin/sh
      export QT_QPA_PLATFORM=wayland
      ${pkgs.dbus}/bin/dbus-run-session \
      ${pkgs.kdePackages.kwin}/bin/kwin_wayland \
      "${pkgs.kdePackages.plasma-workspace}/bin/plasmashell" #-p org.kde.plasma.bigscreen"
    '')
  ];

}
