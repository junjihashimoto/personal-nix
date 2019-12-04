{ pkgs ? import <nixpkgs> {} }:
with pkgs;
vscode-with-extensions.override {
    # When the extension is already available in the default extensions set.
    vscodeExtensions = with vscode-extensions; [
      alanz.vscode-hie-server
      bbenoist.Nix
      cmschuetz12.wal
      formulahendry.auto-close-tag
      james-yu.latex-workshop
      justusadam.language-haskell
      ms-azuretools.vscode-docker
      ms-kubernetes-tools.vscode-kubernetes-tools
      ms-vscode.Go
      ms-vscode.cpptools
      ms-python.python
      redhat.vscode-yaml
      skyapps.fish-vscode
      vscodevim.vim
      llvm-org.lldb-vscode
      WakaTime.vscode-wakatime
    ];
  }
