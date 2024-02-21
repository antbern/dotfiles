{
  description = "A Flake containing the terminal applicaitons";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs";
	flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }: 
	  flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages = [ 
		  pkgs.cowsay 
		  pkgs.jq
		];
      });
  
}
