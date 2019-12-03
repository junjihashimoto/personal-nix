{ pkgs ? import <nixpkgs> {}}:

pkgs.python3.withPackages (pkgs: with pkgs; [
  ipython
  pytorchWithCuda
])
