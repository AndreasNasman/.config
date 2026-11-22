# Configuration derived from:
# `nix flake init --template nix-darwin/master`
{
  inputs,
  pkgs,
  user,
  ...
}:
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
  ];

  nix = {
    package = pkgs.lix;
    # Necessary for using flakes on this system.
    settings.experimental-features = "nix-command flakes";
  };

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  system = {
    # Set Git commit hash for darwin-version.
    configurationRevision = inputs.self.rev or inputs.self.dirtyRev or null;
    # Necessary for using Homebrew (as root).
    primaryUser = "andreas";
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 7;
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";

  # Necessary for using Home Manager.
  users.users.${user}.home = "/Users/${user}";

  homebrew = {
    enable = true;
    casks = [
      "raycast"
    ];
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };
  };
}
