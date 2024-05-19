{ lib
, stdenvNoCC
, libffi
, SDL2
, SDL2_ttf
, SDL2_image
, ncurses
, openssl
, zstd
, makeWrapper
}:

stdenvNoCC.mkDerivation rec {
  pname = "lem";
  version = "2.2.0";

  src = ./artifacts;

  strictDeps = true;

  nativeBuildInputs = [ makeWrapper ];

  buildInputs = [
    libffi
    SDL2
    SDL2_ttf
    SDL2_image
    ncurses
    openssl
    zstd.out
  ];

  dontUnpack = true;
  dontPatch = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -Dm755 -t $out/bin $src/lem

    runHook postInstall
  '';

  fixupPhase = ''
    runHook preFixup

    wrapProgram $out/bin/lem \
      --prefix PATH ':' ${lib.makeBinPath buildInputs} \
      --prefix LD_LIBRARY_PATH ':' ${lib.makeLibraryPath buildInputs}

    runHook postFixup
  '';

  meta = with lib; {
    description = "Common Lisp editor and IDE";
    homepage = "http://lem-project.github.io/";
    mainProgram = "lem";
    platforms = platforms.linux;
    license = licenses.mit;
  };
}
