# crucible_nix
Nix configuration for building the crucible suite

General instructions:

1. Clone this repo locally . (e.g. ~/dev/crucible_nix)
2. If you are going to work on something in crucible, clone that as well (e.g. ~/dev/crucible)
3. `$ cd ~/dev/crucible_nix`
4. `$ bash setup.sh ~/dev/crucible` (if you didn't do step 2, just pass `.` as the last argument above; anything not checked out locally will be obtained from github or hackage.)
5. Read the usage instructions at the end of crucible_project.nix
