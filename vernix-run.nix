{ crucible-src
, crucible-llvm-src
, galois-matlab-src
, language-sally-src
, parameterized-utils-src
, vernix-src
, projectdef
}:
with (import <nixpkgs> {});
let
  pybuilder = pkgs.python36.withPackages (pp: with pp; [ thespian setproctitle ]);
in rec {
  vernix_output = stdenv.mkDerivation rec {
    name = "crucible-master";
    description = "Package build specification for the ${name} project";
    system = builtins.currentSystem;
    phases = [ "installPhase" ];
    installPhase =
      ''
        set -x
        mkdir hackage
        curl --cacert ${cacert}/etc/ssl/certs/ca-bundle.crt \
             --compressed \
             -o hackage/01-index.tar.gz \
             https://hackage.haskell.org/01-index.tar.gz
        gunzip  hackage/01-index.tar.gz || mv hackage/01-index.tar.gz hackage/01-index.tar
        python3 $vernix/bin/vernix $src/crucible.vx2 --noisy \
          crucible: ${crucible-src} \
          crucible-llvm: ${crucible-llvm-src} \
          galois-matlab: ${galois-matlab-src} \
          language-sally: ${language-sally-src} \
          parameterized-utils: ${parameterized-utils-src} \
          here= $out \
          ${projectbld}= $out \
          --static --nolocal
        mkdir $out
        cp *.nix $out/;
        cp $src/*.nix $out/;
      '';
    buildInputs = [ vernix pybuilder git cacert nix-prefetch-git cabal2nix cacert curl gzip ];
    src = ./.;
    inherit vernix crucible-src crucible-llvm-src galois-matlab-src language-sally-src parameterized-utils-src;
  };

  # Get the latest version.  The src override is not strictly.
  # necessary if the default.nix specifies the local path
  # as the source location, but it does not hurt to be
  # explicit in this situation.
  vernix = lib.overrideDerivation (callPackage vernix-src {}) (attrs: { src = vernix-src; });
}
