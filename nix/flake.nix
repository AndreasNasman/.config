{
  description = "Andreas's nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager }:
  let
    username = "andreas";
    configuration = { pkgs, ... }: {
      users = {
        knownUsers = [ "${username}" ];
        users.${username} = {
          home = "/Users/${username}";
          name = "${username}";
          shell = pkgs.fish;
          uid = 501; # https://github.com/nix-darwin/nix-darwin/issues/1237
        };
      };

      nixpkgs.config.allowUnfree = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages = [
        pkgs.aerospace
        pkgs.cargo
        pkgs.delta
        pkgs.fd
        pkgs.git
        pkgs.google-chrome
        pkgs.kitty
        pkgs.lazygit
        pkgs.neovim
        pkgs.nodejs
        pkgs.obsidian
        pkgs.raycast
        pkgs.ripgrep
        pkgs.slack
        pkgs.tailscale
        pkgs.vim
        pkgs.zoom-us
      ];

      homebrew = {
        casks = [
          "1password"
          "grammarly-desktop"
          "notion"
          "parallels"
          "ukelele"
        ];
        enable = true;
        masApps = {
          "Xcode" = 497799835;
        };
        onActivation.autoUpdate = true;
        onActivation.cleanup = "zap";
        onActivation.upgrade = true;
      };

      fonts.packages = [
        pkgs.jetbrains-mono
        pkgs.nerd-fonts.symbols-only
      ];

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Enable alternative shell support in nix-darwin.
      programs.fish.enable = true;

      system.defaults = {
        dock.autohide = true;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
        NSGlobalDomain.InitialKeyRepeat = 15;
        NSGlobalDomain.KeyRepeat = 2;
        trackpad.Clicking = true;
      };

      system.keyboard = {
        enableKeyMapping = true;
        nonUS.remapTilde = true;
        remapCapsLockToEscape = true;
      };

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#Andreass-MacBook-Pro
    darwinConfigurations."Andreass-MacBook-Pro" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            user = "${username}";
          };
        }
        home-manager.darwinModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${username} = ./home.nix;
          };
        }
      ];
    };
  };
}
