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
    glibc         # glibc ( probably preinstalled on your system )
    glibc.static  # glibc 
  ];
}
