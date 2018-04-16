{
  jobsets = (import <nixpkgs> {}).stdenv.mkDerivation {
    name = "crucible-jobsets";
    version = "1";
    src = ./.;
    phases = [ "installPhase" ];
    installPhase = "cp $jsonfile $out";
    jsonfile = builtins.toFile "crucible_jobsets.json"
      ''
        {
          "projectbld": {
            "description": "Build project crucible nix description",
            "nixexprinput": "projectdef",
            "nixexprpath": "./vernix-run.nix",
            "enabled": 1,
            "hidden": false,
            "checkinterval": 300,
            "schedulingshares": 1,
            "enableemail": true,
            "emailoverride": "",
            "keepnr": 3,
            "inputs": {
              "projectdef": {
                "type": "git",
                "value": "https://github.com/kquick/crucible_nix",
                "emailresponsible": true
              },
              "vernix-src": {
                "type": "git",
                "value": "https://github.com/kquick/vernix.git",
                "emailresponsible": true
              },
              "crucible-llvm-src": {
                "type": "git",
                "value": "https://github.com/GaloisInc/crucible.git master 0",
                "emailresponsible": false
              },
              "crucible-src": {
                "type": "git",
                "value": "https://github.com/GaloisInc/crucible.git master 0",
                "emailresponsible": false
              },
              "galois-matlab-src": {
                "type": "git",
                "value": "https://github.com/GaloisInc/crucible.git master 0",
                "emailresponsible": false
              },
              "language-sally-src": {
                "type": "git",
                "value": "https://github.com/GaloisInc/language-sally.git master 0",
                "emailresponsible": false
              },
              "parameterized-utils-src": {
                "type": "git",
                "value": "https://github.com/GaloisInc/parameterized-utils.git master 0",
                "emailresponsible": false
              },
              "nixpkgs": {
                "type": "git",
                "value": "https://github.com/NixOS/nixpkgs-channels nixos-unstable",
                "emailresponsible": false
              }
            }
          },
          "ghc822-nixos-18.03": {
            "description": "Build with ghcver ghc822, nixpkgs_version nixos-18.03",
            "nixexprinput": "projectbld",
            "nixexprpath": "./crucible-project.nix",
            "enabled": 1,
            "hidden": false,
            "checkinterval": 300,
            "schedulingshares": 1,
            "enableemail": true,
            "emailoverride": "",
            "keepnr": 3,
            "inputs": {
              "projectbld": {
                "type": "build",
                "value": "crucible:projectbld:vernix_output",
                "emailresponsible": true
              },
              "centos7_rpm_closure": {
                "type": "build",
                "value": "vm_disk_images:rpmclosures:centos7_x86-64_rpm_closure",
                "emailresponsible": false
              },
              "ghcver": {
                "type": "string",
                "value": "ghc822",
                "emailresponsible": false
              },
              "nixpkgs_version": {
                "type": "string",
                "value": "nixos-18.03",
                "emailresponsible": false
              },
              "crucible-llvm-src": {
                "type": "git",
                "value": "https://github.com/GaloisInc/crucible.git master 0",
                "emailresponsible": false
              },
              "crucible-src": {
                "type": "git",
                "value": "https://github.com/GaloisInc/crucible.git master 0",
                "emailresponsible": false
              },
              "galois-matlab-src": {
                "type": "git",
                "value": "https://github.com/GaloisInc/crucible.git master 0",
                "emailresponsible": false
              },
              "language-sally-src": {
                "type": "git",
                "value": "https://github.com/GaloisInc/language-sally.git master 0",
                "emailresponsible": false
              },
              "parameterized-utils-src": {
                "type": "git",
                "value": "https://github.com/GaloisInc/parameterized-utils.git master 0",
                "emailresponsible": false
              },
              "nixpkgs": {
                "type": "git",
                "value": "https://github.com/NixOS/nixpkgs-channels nixos-18.03",
                "emailresponsible": false
              }
            }
          },
          "ghc822-nixos-unstable": {
            "description": "Build with ghcver ghc822, nixpkgs_version nixos-unstable",
            "nixexprinput": "projectbld",
            "nixexprpath": "./crucible-project.nix",
            "enabled": 1,
            "hidden": false,
            "checkinterval": 300,
            "schedulingshares": 1,
            "enableemail": true,
            "emailoverride": "",
            "keepnr": 3,
            "inputs": {
              "projectbld": {
                "type": "build",
                "value": "crucible:projectbld:vernix_output",
                "emailresponsible": true
              },
              "centos7_rpm_closure": {
                "type": "build",
                "value": "vm_disk_images:rpmclosures:centos7_x86-64_rpm_closure",
                "emailresponsible": false
              },
              "ghcver": {
                "type": "string",
                "value": "ghc822",
                "emailresponsible": false
              },
              "nixpkgs_version": {
                "type": "string",
                "value": "nixos-unstable",
                "emailresponsible": false
              },
              "crucible-llvm-src": {
                "type": "git",
                "value": "https://github.com/GaloisInc/crucible.git master 0",
                "emailresponsible": false
              },
              "crucible-src": {
                "type": "git",
                "value": "https://github.com/GaloisInc/crucible.git master 0",
                "emailresponsible": false
              },
              "galois-matlab-src": {
                "type": "git",
                "value": "https://github.com/GaloisInc/crucible.git master 0",
                "emailresponsible": false
              },
              "language-sally-src": {
                "type": "git",
                "value": "https://github.com/GaloisInc/language-sally.git master 0",
                "emailresponsible": false
              },
              "parameterized-utils-src": {
                "type": "git",
                "value": "https://github.com/GaloisInc/parameterized-utils.git master 0",
                "emailresponsible": false
              },
              "nixpkgs": {
                "type": "git",
                "value": "https://github.com/NixOS/nixpkgs-channels nixos-unstable",
                "emailresponsible": false
              }
            }
          }
        }
      '';
   };
}
