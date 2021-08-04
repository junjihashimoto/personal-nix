{ stdenv, lib, fetchgit,pkgs }:

stdenv.mkDerivation {
  name = "anthy-mode";

  src = ./src;
  buildInputs = [pkgs.anthy];

  installPhase = ''
    mkdir -p $out/share/emacs/site-lisp
    cp *.el $out/share/emacs/site-lisp/
  '';

  meta = {
    description = "Anthy";
    homepage = https://github.com/xorgy/anthy;
    platforms = lib.platforms.all;
  };
}
