# Configuration derived from:
# `nix flake init --template nix-darwin/master`
{
  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    inputs@{ nix-darwin, ... }:
    {
      darwinConfigurations."haga" = nix-darwin.lib.darwinSystem {
        modules = [
          ./modules/configuration.nix
          ./modules/home-manager.nix
          ./modules/homebrew.nix
        ];
        specialArgs = {
          inherit inputs;
          user = "andreas";
        };
      };
    };
}
