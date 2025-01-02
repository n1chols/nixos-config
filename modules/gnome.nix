{ config, lib, pkgs, ... }: {

  # OPTIONS
  options = {
    modules.gnome = {
      enable = lib.mkEnableOption "";
    };
  };
  
  # CONFIG
  config = lib.mkIf config.modules.gnome.enable {
    # Enable GNOME and GDM
    services.xserver = {
      enable = true;
      displayManager = {
        gdm.enable = true;
        sessionCommands = ''
          gsettings set org.gnome.desktop.interface scaling-factor 2
        '';
      };
      desktopManager.gnome = {
        enable = true;
        extraGSettingsOverrides = ''
          [org/gnome/desktop/interface]
          scaling-factor=2
        '';
      };
    };

    # Enable XDG desktop portal
    xdg.portal = {
      enable = true;
      extraPortals = with pkgs; [ xdg-desktop-portal-gnome ];
    };

    # Disable GNOME core apps and setup
    services.gnome = {
      core-utilities.enable = false;
      gnome-initial-setup.enable = false;
    };

    # Disable the remaining apps
    environment.gnome.excludePackages = (with pkgs; [
      gnome-tour
      gnome-shell-extensions
    ]);
  };

}
