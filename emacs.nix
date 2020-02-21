{ pkgs ? import <nixpkgs> { } }:

# See https://nixos.org/nixos/manual/#module-services-emacs

let
  myEmacs = pkgs.emacs26;
  emacsWithPackages = (pkgs.emacsPackagesNgGen myEmacs).emacsWithPackages;
  anthy-mode = pkgs.emacsPackages.callPackage ./anthy-mode {};
  vrml-mode = pkgs.emacsPackages.callPackage ./vrml-mode {};
  my-config = (epkgs: pkgs.emacsPackages.trivialBuild {
    pname = "my-mode";
    version = "2019-12-03";
    src = pkgs.writeText "default.el" ''
      (package-initialize)
      (global-set-key "\C-x\C-g" 'goto-line)
      (autoload 'lsp-mode "lsp-mode" nil t)
      (setq lsp-prefer-flymake nil)
      (add-hook 'haskell-mode-hook #'lsp)
      (autoload 'lsp-ui "lsp-ui" nil t)
      (add-hook 'lsp-mode-hook 'lsp-ui-mode)
      (add-hook 'haskell-mode-hook 'flycheck-mode)
      (autoload 'lsp-haskell "lsp-haskell" nil t)
      (setq default-input-method "japanese-anthy")
      (define-key global-map [?¥] nil)
      (define-key local-function-key-map [?¥] [?\\])
      (define-key local-function-key-map [?\C-¥] [?\C-\\])
      (define-key local-function-key-map [?\M-¥] [?\M-\\])
      (define-key local-function-key-map [?\C-\M-¥] [?\C-\M-\\])
      (autoload 'vrml-mode "vrml-mode" "VRML mode." t)
      (setq auto-mode-alist (append '(("\\.wrl\\'" . vrml-mode) ("\\.wbt\\'" . vrml-mode))
                                    auto-mode-alist))
    '';
  });
in
  emacsWithPackages (epkgs: (with epkgs.melpaStablePackages;[
  ]) ++ (with epkgs.melpaPackages;[
    wgrep
  ]) ++ (with epkgs.elpaPackages;[
  ]) ++ [
    anthy-mode
    vrml-mode
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
    (my-config epkgs)
  ])
