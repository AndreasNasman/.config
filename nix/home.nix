{
  config,
  lib,
  pkgs,
  ...
}:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "andreas";
  home.homeDirectory = "/Users/andreas";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
    ".hushlogin".text = "";
    ".ssh/config".text = ''
      Host *
        IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
    '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/andreas/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.activation = {
    # Symlinked keyboard layouts don't show up in Input Sources.
    copyKeyboardLayout = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      run cp -f ${../ukelele}/* $HOME/Library/Keyboard\ Layouts/
    '';
    copyFirefoxStyleSheet = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      find $HOME/Library/Application\ Support/Firefox/Profiles/ -type d -name "*.default-release-*" -exec mkdir -p "{}/chrome/" \; -exec cp -f ${../firefox}/userChrome.css "{}/chrome/" \;
    '';
    # We must call `defaults` directly since it isn't in PATH.
    # Also, `write` requires a non-quoted absolute path to work.
    disableCursorLocationMagnification = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      run /usr/bin/defaults write ~/Library/Preferences/.GlobalPreferences CGDisableCursorLocationMagnification -bool true
    '';
    hideIdleCursor = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      run /usr/bin/defaults write ~/Library/Preferences/com.doomlaser.cursorcerer.plist idleHide 3
    '';
    preventSleepOnPowerAdapter = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      run /usr/bin/sudo /usr/bin/pmset -c sleep 0
    '';
  };
}
