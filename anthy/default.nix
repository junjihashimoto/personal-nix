{ stdenv, fetchgit }:

stdenv.mkDerivation {
  name = "anthy-mode";

  src = ./src;

  installPhase = ''
    mkdir -p $out/share/emacs/site-lisp
    cp *.el $out/share/emacs/site-lisp/
  '';

  meta = {
    description = "Anthy";
    homepage = https://github.com/xorgy/anthy;
    platforms = stdenv.lib.platforms.all;
  };
}
