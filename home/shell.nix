{username, lib, ...}: {
  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "vscode"
        "terraform"
        "ansible"
        "kubectl"
        "gh"
        "last-working-dir"
        "macos"
        "gradle"
        "opentofu"
      ];
    };

    initContent = lib.mkBefore ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      # Remove history data we don't want to see
      export HISTIGNORE="pwd:ls:cd"

      # Emacs is my editor
      export ALTERNATE_EDITOR=""
      export EDITOR="vim"
      export VISUAL="vim"

      # nix shortcuts
      shell() {
          nix-shell '<nixpkgs>' -A "$1"
      }

      # Use difftastic, syntax-aware diffing
      alias diff=difft

      # Always color ls and group directories
      alias ls='ls --color=auto'

      # Add Visual Studio Code (code)
      export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

      # Setup the brew package manager for GUI apps
      eval "$(/opt/homebrew/bin/brew shellenv)"

      # nix does not provide sdkman package :/
      # THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
      export SDKMAN_DIR="/Users/${username}/.sdkman"
      [[ -s "/Users/${username}/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/${username}/.sdkman/bin/sdkman-init.sh"
    '';
  };

  home.shellAliases = {
    k = "kubectl";
  };
}
