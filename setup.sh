if [ $# -ne 1 ] ; then
    echo "Usage: $0 dev-root-dir"
    echo ""
    echo "Builds module nix files in local directory for sources in dev-root-dir"
    exit 1
fi

devroot=${1}

public_crucible_root=https://github.com/GaloisInc/crucible
crucible_root=${public_crucible_root}

declare -A projloc=([language-sally]=https://github.com/GaloisInc/language-sally.git
                    [blt]=https://github.com/GaloisInc/blt.git
                    [parameterized-utils]=https://github.com/GaloisInc/parameterized-utils.git
                    [crucible]=${crucible_root}/crucible.git
                    [crucible-abc]=${crucible_root}/crucible.git
                    [crucible-blt]=${crucible_root}/crucible.git
                    [crucible-llvm]=${crucible_root}/crucible.git
                    [galois-matlab]=${crucible_root}/crucible.git
                    [llvm-pretty]=cabal://llvm-pretty
                    [llvm-pretty-bc-parser]=cabal://llvm-pretty-bc-parser
                    [th-abstraction]=cabal://th-abstraction
                   )

declare -A projarg=([crucible]="--subpath crucible"
                    [crucible-abc]="--subpath crucible-abc"
                    [crucible-blt]="--subpath crucible-blt"
                    [crucible-llvm]="--subpath crucible-llvm"
                    [galois-matlab]="--subpath galois-matlab"
                   )

declare -A cabal2nixarg=()

for d in language-sally \
             blt \
             parameterized-utils \
             crucible/crucible \
             crucible/crucible-abc \
             crucible/crucible-blt \
             crucible/crucible-llvm \
             crucible/galois-matlab \
             llvm-pretty \
             llvm-pretty-bc-parser \
             galois-matlab \
             th-abstraction \
         ; do
    echo "#### $d"
    projname=$(basename $d)
    cabalfile=$(find ${devroot} -name "${projname}.cabal")
    if [ ! -z "${cabalfile}" ] ; then
        echo "cabal2nix $(dirname ${cabalfile}) ${cabal2nixarg[$projname]} > ${projname}.nix #1"
        cabal2nix $(dirname ${cabalfile}) ${cabal2nixarg[$projname]} > ${projname}.nix
    else
        echo "cabal2nix ${projloc[$projname]} ${projarg[$projname]} ${cabal2nixarg[$projname]} > ${projname}.nix #2"
        cabal2nix ${projloc[$projname]} ${projarg[$projname]} ${cabal2nixarg[$projname]} > ${projname}.nix
    fi
done
