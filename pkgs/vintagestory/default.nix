{
  lib,
  stdenv,
  fetchurl,
  makeWrapper,
  xorg,
  gtk2,
  sqlite,
  openal,
  cairo,
  libGLU,
  SDL2,
  freealut,
  libglvnd,
  pipewire,
  libpulseaudio,
  dotnet-runtime_7,
}:

stdenv.mkDerivation rec {
  pname = "vintagestory";
  version = "1.20.5";

  src = fetchurl {
    url = "https://cdn.vintagestory.at/gamefiles/stable/vs_client_linux-x64_${version}.tar.gz";
    hash = "sha256-+nEyFlLfTAOmd8HrngZOD1rReaXCXX/ficE/PCLcewg=";
  };

  nativeBuildInputs = [ makeWrapper ];

  buildInputs = [ dotnet-runtime_7 ];

  runtimeLibs = lib.makeLibraryPath [
    gtk2
    sqlite
    openal
    cairo
    libGLU
    SDL2
    freealut
    libglvnd
    pipewire
    libpulseaudio
    xorg.libX11
    xorg.libXi
    xorg.libXcursor
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/vintagestory $out/bin
    cp -r * $out/share/vintagestory
    runHook postInstall
  '';

  preFixup = ''
    makeWrapper ${dotnet-runtime_7}/bin/dotnet $out/bin/vintagestory \
      --prefix LD_LIBRARY_PATH : "${runtimeLibs}" \
      --add-flags $out/share/vintagestory/Vintagestory.dll
    makeWrapper ${dotnet-runtime_7}/bin/dotnet $out/bin/vintagestory-server \
      --prefix LD_LIBRARY_PATH : "${runtimeLibs}" \
      --add-flags $out/share/vintagestory/VintagestoryServer.dll
    find "$out/share/vintagestory/assets/" -not -path "*/fonts/*" -regex ".*/.*[A-Z].*" | while read -r file; do
      local filename="$(basename -- "$file")"
      ln -sf "$filename" "''${file%/*}"/"''${filename,,}"
    done
  '';
}
