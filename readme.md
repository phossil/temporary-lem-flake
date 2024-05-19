# temporary lem flake

this is a really dumb and temporary flake for lem

please do not use this unless you understand why this is dumb

i manually built lem on nixos and included the resulting binary here

if you want to try building lem yourself you can probably start by trying this:
```shell
$ nix develop .\#
$ cd wherever-your-copy-of-the-lem-source-is
$ rlwrap sbcl

* (ql:quickload :qlot)
* (qlot:install)
* (quit)
$ sbcl --noinform --no-sysinit --no-userinit --load .qlot/setup.lisp --load scripts/build-sdl2-ncurses.lisp
```
be aware i have not tested the commands in the exact order as shown above

~~hopefully this flake won't be needed for long because this is very much not the nix way aaaaaaaaaaa~~

if you can, please submit lem to nixpkgs

LICENSE: `flake.nix` and `lem-bin.nix` are Public Domain.