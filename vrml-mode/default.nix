{ stdenv, fetchgit,pkgs }:

stdenv.mkDerivation {
  name = "vrml-mode";

  src = ./.;

  installPhase = ''
    mkdir -p $out/share/emacs/site-lisp
    cp *.el $out/share/emacs/site-lisp/
  '';

  meta = {
    description = "vrml-mode";
    platforms = stdenv.lib.platforms.all;
  };
}
