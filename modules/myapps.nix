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
    environment.systemPackages = 
      (lib.optionals config.modules.myapps.systemApps (with pkgs; [
        firefox
        thunderbird
        gedit
        loupe
        celluloid
        nautilus
        mission-center
        blackbox-terminal
        git
      ])) ++
      (lib.optionals config.modules.myapps.officeApps (with pkgs; [
        libreoffice
      ]));

    # Setup file associations
    xdg.mime.defaultApplications =
      (lib.optionalAttrs config.modules.myapps.systemApps {
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "application/pdf" = "firefox.desktop";
        "application/zip" = "nautilus.desktop";
        "application/gzip" = "nautilus.desktop";
        "application/x-rar" = "nautilus.desktop";
        "application/x-7z-compressed" = "nautilus.desktop";
        "text/*" = "zed.desktop";
        "image/*" = "loupe.desktop";
        "video/*" = "celluloid.desktop";
      }) //
      (lib.optionalAttrs config.modules.myapps.officeApps {
        "application/msword" = "libreoffice-writer.desktop";
        "application/vnd.ms-excel" = "libreoffice-calc.desktop";
        "application/vnd.ms-powerpoint" = "libreoffice-impress.desktop";
      });
  };

}
