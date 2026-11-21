# Configuration derived from:
# https://github.com/zhaofengli/nix-homebrew#a-new-installation
{
  inputs,
  user,
  ...
}:
{
  imports = [
    inputs.nix-homebrew.darwinModules.nix-homebrew
  ];

  nix-homebrew = {
    enable = true;
    user = user;
  };
}
