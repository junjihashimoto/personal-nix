{ pkgs ? import <nixpkgs> {} }:

let
  myEmacs = pkgs.emacs25;
  emacsWithPackages = (pkgs.emacsPackagesNgGen myEmacs).emacsWithPackages;
in
  emacsWithPackages (epkgs: (with epkgs.melpaStablePackages;[
  ]) ++ (with epkgs.melpaPackages;[
  ]) ++ (with epkgs.elpaPackages;[
  ]) ++ [
    epkgs.yaml-mode
    epkgs.nix-mode
    epkgs.php-mode
    epkgs.go-mode
    epkgs.flycheck
    epkgs.flycheck-haskell
    epkgs.haskell-mode
    epkgs.lsp-mode
    epkgs.lsp-ui
    epkgs.lsp-haskell
    epkgs.yasnippet
  ])
