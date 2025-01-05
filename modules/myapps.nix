{ config, lib, pkgs, ... }: {

  # OPTIONS
  options.modules.myapps = {
    enable = lib.mkEnableOption "";
  };
  
  # CONFIG
  config = lib.mkIf config.modules.myapps.enable {
    # Add applications
    environment.systemPackages = 
      firefox
      thunderbird
      loupe
      celluloid
      nautilus
      mission-center
      blackbox-terminal
      git
      cage
    ];

    # Setup file associations
    xdg.mime.defaultApplications = {
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
    };
  };

}
