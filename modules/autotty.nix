{ config, lib, pkgs, ... }: {


  options = {
    modules.autotty = {
      enable = lib.mkEnableOption "";
    };
  };

  config = lib.mkIf config.modules.autotty.enable {
    services.xserver.displayManager.enabled = false;
    
    services.getty.autologinUser = "user";

    systemd.user.services = {
      tty1-gnome = {
        wantedBy = [ "default.target" ];
        serviceConfig = {
          ExecStart = "${pkgs.gnome.gnome-session}/bin/gnome-session";
          TTYPath = "/dev/tty1";
        };
      };

      tty2-steam = {
        wantedBy = [ "default.target" ];
        serviceConfig = {
          ExecStart = "${pkgs.gamescope}/bin/gamescope -f -- ${pkgs.steam}/bin/steam -bigpicture";
          TTYPath = "/dev/tty2";
        };
      };

      tty3-kodi = {
        wantedBy = [ "default.target" ];
        serviceConfig = {
          ExecStart = "${pkgs.kodi}/bin/kodi-standalone";
          TTYPath = "/dev/tty3";
        };
      };
    };
  };

}
