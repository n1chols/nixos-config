{
  lib,
  stdenv,
  fetchurl,
  python312,
  SDL2,
  libvorbis,
  openal,
  libgcc,
  makeWrapper,
  autoPatchelfHook,
  writeShellApplication
}:

stdenv.mkDerivation {
  pname = "bombsquad";
  version = "1.7.38";

  src = fetchurl {
    url = "https://files.ballistica.net/bombsquad/builds/BombSquad_Linux_x86_64_$version.tar.gz";
    hash = "sha256-aujLYzFcKaW0ff7sRdyJ6SvSQowafWVbmwycQfDQUYY=";
  };

  nativeBuildInputs = [
    python312
    SDL2
    libvorbis
    openal
    libgcc
    makeWrapper
    autoPatchelfHook
    copyDesktopItems
  ];

  installPhase = ''
    runHook preInstall

    base="BombSquad_Linux_x86_64_$version"

    install -m755 -D $base/bombsquad $out/bin/bombsquad
    install -dm755 $base/ba_data $out/usr/share/bombsquad/ba_data
    cp -r $base/ba_data $out/usr/share/bombsquad/

    wrapProgram "$out/bin/bombsquad" \
      --add-flags "-d $out/usr/share/bombsquad"

    runHook postInstall
  '';
}
