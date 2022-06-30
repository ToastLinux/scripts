with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "busybox";
  buildInputs = [
    git
    gnutar   # tar
    utillinux
  ];
}
