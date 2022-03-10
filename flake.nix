{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    poetry2nix-src.url = "github:nix-community/poetry2nix";
  };

  outputs = { self, nixpkgs, poetry2nix-src }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [ poetry2nix-src.overlay ];
      };
    in {
      packages.${system} = {
        nbpreview = pkgs.poetry2nix.mkPoetryApplication {
          projectDir = ./.;
          buildInputs = [ pkgs.poetry ];
          doCheck = false;
        };
      };
    };
}
