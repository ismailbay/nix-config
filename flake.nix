{
  description = "ismailbay's nix-config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-23.11-darwin";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, 
              nixpkgs, 
              home-manager,
              nix-darwin,
              nix-index-database,
              ...}: {

    darwinConfigurations.melamar = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";

      modules = [ ./machines/melamar/default.nix ];
    };

  };
}
