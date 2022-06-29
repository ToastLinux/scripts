with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "busybox";
  buildInputs = [
    wget
    gawk
    bc
    bison
    flex
    gnutar   # tar
    gnumake  # make
    gcc
    glibc
    elfutils
    openssl
  ];
}
