{
  description = "a really dumb and temporary flake for lem";

  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-unstable;

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      lib = nixpkgs.lib;
    in
    {
      # wowie, a build of lem !!
      packages.${system}.default = pkgs.callPackage ./lem-bin.nix { };

      # a (hopefully) helpful shell to build the lem binary yourself
      devShells.${system}.default = pkgs.mkShell rec {
        nativeBuildInputs = with pkgs; [
          rlwrap
          sbcl
        ];
        buildInputs = with pkgs; [
          openssl
          libffi
          SDL2
          SDL2_ttf
          SDL2_image
          ncurses
          zstd.out
        ];
        LD_LIBRARY_PATH = lib.makeLibraryPath buildInputs;
      };

      # make the flake look pretty :)
      # hint: use the command `nix fmt`
      formatter.${system} = pkgs.nixpkgs-fmt;
    };
}
