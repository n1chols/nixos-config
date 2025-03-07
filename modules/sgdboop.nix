{ config, lib, pkgs, ... }:

let
  sgdboop = pkgs.stdenv.mkDerivation {
    pname = "sgdboop";
    version = "1.2.8";  # Update this if there’s a newer version
    src = ./sgdboop-files;  # Points to your local directory with the files

    # No buildInputs needed since we’re using the provided libiup.so
    installPhase = ''
      mkdir -p $out/bin $out/lib $out/share/applications
      install -Dm755 SGDBoop $out/bin/SGDBoop
      install -Dm644 libiup.so $out/lib/libiup.so
      install -Dm644 com.steamgriddb.SGDBoop.desktop $out/share/applications/com.steamgriddb.SGDBoop.desktop
    '';

    meta = with lib; {
      description = "Apply Steam assets from SteamGridDB";
      homepage = "https://github.com/SteamGridDB/SGDBoop";
      license = licenses.mit;  # Adjust if the actual license differs
      platforms = platforms.linux;
    };
  };
in
{
  # Add SGDBoop to your system packages
  environment.systemPackages = [ sgdboop ];

  # Set up the sgdb:// protocol handler
  xdg.mime.defaultApplications = {
    "x-scheme-handler/sgdb" = "com.steamgriddb.SGDBoop.desktop";
  };
}
