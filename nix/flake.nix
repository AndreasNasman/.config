# Configuration derived from:
# `nix flake init --template nix-darwin/master`
# https://nix-community.github.io/home-manager/nix-flakes/nix-darwin.html
{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
  };

  outputs =
    inputs@{ nix-darwin, ... }:
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#haga
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
