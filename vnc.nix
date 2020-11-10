with (import <nixpkgs> {});
mkShell {
  buildInputs = [
    x11vnc
    xvfb_run
    xfce.xfconf
    xfce.xfce4-session
  ];
}
