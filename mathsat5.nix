{stdenv, fetchurl, gmp
}:

let version = "5.4.1";
    version-hash = "0yr8lj8drfyg1ygyzzxa6wpkra534k95wgrvrf2a2d307nny4kwy";
in

stdenv.mkDerivation {
  name = "mathsat-${version}";

  src = fetchurl {
    url = "http://mathsat.fbk.eu/download.php?file=mathsat-${version}-linux-x86_64.tar.gz";
    sha256 = "${version-hash}";
  };

  phases = [ "unpackPhase" "installPhase" ];  # distributed in binary form only

  installPhase = ''
    mkdir -p $out/bin
    mv bin/mathsat $out/bin/
    mkdir -p $out/lib
    mv lib/libmathsat.a $out/lib/
    mkdir -p $out/include
    mv include/*.h $out/include/
  '';

  propagatedBuildInputs = [ gmp ];

  meta = with stdenv.lib; {
    homepage = http://mathsat.fbk.eu;
    description = "An SMT Solver for Formal Verification & More";
    license = licenses.unfree;
    platforms = platforms.linux;
  };
}
