{ lib
, stdenvNoCC
, fetchgit
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

  # if you thought the existence of this flake was stupid,
  # wait until you see this 
  src = fetchgit {
    url = "https://github.com/phossil/temporary-lem-flake/";
    # we will be using a specifc branch (binary-x86_64-linux) because
    # nix flakes can't seem to download a git repo with lfs ??
    rev = "4239a7126ab06fc6330d0e0db69b5346adf44954";
    hash = "sha256-EAE6HEXym6MqN1v/Za98Tmg/9qcFlswoTXwtYsojT8w=";
    fetchLFS = true;
  };

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
