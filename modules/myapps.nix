{ config, lib, pkgs, ... }: {

  # OPTIONS
  options = {
    modules.myapps = {
      enable = lib.mkEnableOption "";
      systemApps = lib.mkEnableOption "";
      officeApps = lib.mkEnableOption "";
    };
  };
  
  # CONFIG
  config = lib.mkIf config.modules.myapps.enable {
    # Add applications
    environment.systemPackages = with pkgs; [
      (lib.optionals config.modules.myapps.systemApps [
        firefox
        thunderbird
        zed
        mission-center
        blackbox
        nemo
        mpv
        imv
        zathura
      ]) ++
      (lib.optionals config.modules.myapps.officeApps [
        libreoffice
      ])
    ];

    # Setup file associations
    xdg.mime.defaultApplications = {
      (lib.optionals config.modules.myapps.systemApps {
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "application/pdf" = "org.pwmt.zathura.desktop";
        "application/zip" = "nemo.desktop";
        "application/gzip" = "nemo.desktop";
        "application/x-rar" = "nemo.desktop";
        "application/x-7z-compressed" = "nemo.desktop";
        "text/*" = "zed.desktop";
        "image/*" = "imv.desktop";
        "video/*" = "mpv.desktop";
      }) //
      (lib.optionals config.modules.myapps.officeApps {
        "application/msword" = "libreoffice-writer.desktop";
        "application/vnd.ms-excel" = "libreoffice-calc.desktop";
        "application/vnd.ms-powerpoint" = "libreoffice-impress.desktop";
      })
    };
  };

}
