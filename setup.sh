if [ $# -ne 1 ] ; then
    echo "Usage: $0 dev-root-dir"
    echo ""
    echo "Builds module nix files in local directory for sources in dev-root-dir"
    exit 1
fi

devroot=${1}

public_crucible_root=https://github.com/GaloisInc/crucible
private_crucible_root=https://gitlab-int.galois.com/tanager
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
                   )

declare -A projarg=([language-sally]="--revision 34289ca05"
                    [blt]="--revision 2ab49784"
                    [parameterized-utils]="--revision 2461f7f0"
                    [crucible]="--subpath crucible"
                    [crucible-abc]="--subpath crucible-abc"
                    [crucible-blt]="--subpath crucible-blt"
                    [crucible-llvm]="--subpath crucible-llvm"
                    [galois-matlab]="--subpath crucible-llvm"
                   )

declare -A cabal2nixarg=()

for d in ${devroot}/dependencies/language-sally \
                   ${devroot}/dependencies/blt \
                   ${devroot}/dependencies/parameterized-utils \
                   ${devroot}/dependencies/crucible/crucible \
                   ${devroot}/dependencies/crucible/crucible-abc \
                   ${devroot}/dependencies/crucible/crucible-blt \
                   ${devroot}/dependencies/crucible/crucible-llvm \
                   ${devroot}/dependencies/crucible/galois-matlab \
                   ${devroot}/dependencies/llvm-pretty \
                   ${devroot}/dependencies/llvm-pretty-bc-parser \
                   ${devroot}/matlab-parser \
                   ${devroot}/crucible-matlab \
                   ${devroot}/grackle \
         ; do
    projname=$(basename $d)
    if [ -d $d -a -f ${d}/${projname}.cabal ] ; then
        echo "cabal2nix $d ${cabal2nixarg[$projname]} > ${projname}.nix"
        cabal2nix $d ${cabal2nixarg[$projname]} > ${projname}.nix
    else
        cabalfile=$(find ${devroot} -name ${projname}.cabal)
        if [ ! -z "$cabalfile" ] ; then
            echo "cabal2nix $(dirname ${cabalfile}) ${cabal2nixarg[$projname]} > ${projname}.nix"
            cabal2nix $(dirname ${cabalfile}) ${cabal2nixarg[$projname]} > ${projname}.nix
        else
            echo "cabal2nix ${projloc[$projname]} ${projarg[$projname]} ${cabal2nixarg[$projname]} > ${projname}.nix"
            cabal2nix ${projloc[$projname]} ${projarg[$projname]} ${cabal2nixarg[$projname]} > ${projname}.nix
        fi
    fi
done
