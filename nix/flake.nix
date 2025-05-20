{
  description = "Andreas's nix-darwin system flake";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nix-homebrew,
      home-manager,
    }:
    let
      username = "andreas";
      configuration =
        { pkgs, ... }:
        {
          users = {
            knownUsers = [ "${username}" ];
            users.${username} = {
              home = "/Users/${username}";
              name = "${username}";
              shell = pkgs.fish;
              uid = 501; # https://github.com/nix-darwin/nix-darwin/issues/1237
            };
          };

          nixpkgs = {
            config.allowUnfree = true;
            # The platform the configuration will be used on.
            hostPlatform = "aarch64-darwin";
          };

          # List packages installed in system profile. To search by name, run:
          # $ nix-env -qaP | grep wget
          environment.systemPackages = [
            pkgs.aerospace
            pkgs.delta
            pkgs.deno
            pkgs.ffmpeg
            pkgs.git
            pkgs.kitty
            pkgs.lazygit
            pkgs.neovim
            pkgs.nixfmt-rfc-style
            pkgs.raycast
            pkgs.vim

            # Neovim
            ## Mason LSPs
            pkgs.cargo
            pkgs.nodejs

            ## Swift Treesitter parser
            pkgs.tree-sitter

            ## Telescope
            pkgs.fd
            pkgs.ripgrep

            # Work
            pkgs.slack
            pkgs.zoom-us
          ];

          homebrew = {
            casks = [
              "1password"
              "1password-cli"
              "android-studio"
              "cursorcerer"
              "google-chrome"
              "grammarly-desktop"
              "notion"
              "obsidian"
              "parallels"
              "sf-symbols"
              "tailscale"
              "ukelele"
            ];
            enable = true;
            masApps = {
              "Numbers" = 409203825;
              "Xcode" = 497799835;
            };
            onActivation = {
              autoUpdate = true;
              cleanup = "zap";
              upgrade = true;
            };
          };

          fonts.packages = [
            pkgs.jetbrains-mono
            pkgs.nerd-fonts.symbols-only
          ];

          # Necessary for using flakes on this system.
          nix.settings.experimental-features = "nix-command flakes";

          # Enable alternative shell support in nix-darwin.
          programs.fish.enable = true;

          system = {
            # Set Git commit hash for darwin-version.
            configurationRevision = self.rev or self.dirtyRev or null;
            defaults = {
              finder = {
                FXPreferredViewStyle = "clmv";
                NewWindowTarget = "Other";
                NewWindowTargetPath = "file:///Users/andreas/Downloads/";
              };
              dock = {
                autohide = true;
                persistent-apps = [ ];
                persistent-others = [ ];
                show-recents = false;
                wvous-br-corner = 1;
              };
              NSGlobalDomain = {
                "com.apple.keyboard.fnState" = true;
                AppleInterfaceStyle = "Dark";
                ApplePressAndHoldEnabled = false;
                InitialKeyRepeat = 15;
                KeyRepeat = 2;
              };
              trackpad.Clicking = true;
            };
            keyboard = {
              enableKeyMapping = true;
              nonUS.remapTilde = true;
              remapCapsLockToEscape = true;
            };
            # Used for backwards compatibility, please read the changelog before changing.
            # $ darwin-rebuild changelog
            stateVersion = 6;
          };

          security.pam.services.sudo_local.touchIdAuth = true;
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
