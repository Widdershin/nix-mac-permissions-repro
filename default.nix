let
  pinnedPkgs =
    import (builtins.fetchTarball {
      # Descriptive name to make the store path easier to identify
      name = "nixos-unstable-2018-02-08";
      # Commit hash for nixos-unstable as of 2018-01-06
      url = https://github.com/nixos/nixpkgs/archive/895f9d3b732a036103caff84945b53359eba8392.tar.gz;
      # Hash obtained using `nix-prefetch-url --unpack <url>`
      sha256 = "1817zb963zyr86d88i20s1bybyx96kigps99w74bpam1c0iphrcs";
    }) {};
in
{ pkgs ? pinnedPkgs }:

with pkgs;

let
  pythonWithAwsMfa = import ./nix/requirements.nix {};
in
stdenv.mkDerivation {
  name = "test-environment";
  buildInputs = [ nix awscli pythonWithAwsMfa.interpreter terraform terraform-providers.aws ];
}

