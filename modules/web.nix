{ config, pkgs, ... }: {

  # Ungoogled Chromium
  programs.chromium = {
    enable = true;
    package = ungoogled-chromium;
    extraOpts = {
      "enable-features" = "UseOzonePlatform";
      "ozone-platform" = "wayland";
    };
  };

  # Mozilla Thunderbird
  programs.thunderbird.enable = true;

  xdg.mime.defaultApplications = {
    "x-scheme-handler/mailto" = "thunderbird.desktop";
  };

};
