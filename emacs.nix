{ sources ? import ./nix/sources.nix {},
  pkgs ? import sources.nixpkgs {}
}:

# See https://nixos.org/nixos/manual/#module-services-emacs

let
  myEmacs = pkgs.emacs;
  emacsWithPackages = (pkgs.emacsPackagesNgGen myEmacs).emacsWithPackages;
  anthy-mode = pkgs.emacsPackages.callPackage ./anthy-mode {};
  vrml-mode = pkgs.emacsPackages.callPackage ./vrml-mode {};
  my-config = (epkgs: pkgs.emacsPackages.trivialBuild {
    pname = "my-mode";
    version = "2019-12-03";
    src = pkgs.writeText "default.el" ''
      (package-initialize)
      (global-set-key "\C-x\C-g" 'goto-line)
      (autoload 'lsp "lsp" nil t)
      ;(setq lsp-prefer-flymake nil)
      ;(add-hook 'haskell-mode-hook #'lsp)
      ;(autoload 'lsp-ui "lsp-ui" nil t)
      (add-hook 'lsp-mode-hook (lambda () (progn
        (define-key lsp-mode-map (kbd "C-c C-l") lsp-command-map)
        (lsp-ui-mode)
        (lsp-lens-mode)
        )))
      (add-hook 'haskell-mode-hook 'lsp)
      (setq lsp-haskell-process-path-hie "haskell-language-server")
      (setq lsp-keymap-prefix "\C-c\C-l")
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
      (menu-bar-mode 0)
      (tool-bar-mode 0)
      (scroll-bar-mode 0)
      (setq ring-bell-function 'ignore)
      (defun seq-do-indexed (function sequence)
  "Apply FUNCTION to each element of SEQUENCE and return nil.
Unlike `seq-map', FUNCTION takes two arguments: the element of
the sequence, and its index within the sequence."
  (let ((index 0))
    (seq-do (lambda (elt)
               (funcall function elt index)
               (setq index (1+ index)))
             sequence)))
    (when (require 'ansi-color nil t)
      (defun my-colorize-compilation-buffer ()
        (when (eq major-mode 'compilation-mode)
          (ansi-color-apply-on-region compilation-filter-start (point-max))))
      (add-hook 'compilation-filter-hook 'my-colorize-compilation-buffer))    
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
 #   epkgs.mozc
    epkgs.typescript-mode
    epkgs.yaml-mode
    epkgs.nix-mode
    epkgs.php-mode
    epkgs.go-mode
    epkgs.flycheck
    epkgs.flycheck-haskell
    epkgs.haskell-mode
    epkgs.avy
    epkgs.lsp-mode
    epkgs.lsp-ui
    epkgs.lsp-haskell
    epkgs.yasnippet
    epkgs.elm-mode
    (my-config epkgs)
  ])
