{pkgs, username, ...}: {
  environment.systemPackages = with pkgs; [
    neovim
    git
  ];

  environment.variables.EDITOR = "nvim";

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    # mas failes with 26.1, wait for v4.0.0
    masApps = {
      #"Xcode" = 497799835;
    };

    taps = [
      "homebrew/cask-fonts"
      "homebrew/services"
      "homebrew/cask-versions"
    ];

    brews = [
      # "kafka"
      "talhelper"
    ];

    casks = [
      # Development Tools
      "visual-studio-code"
      "orbstack"
      "zed"
      "headlamp"
      "jetbrains-toolbox"

      # Communication Tools
      "discord"

      # Utility Tools
      "rectangle"
      "sanesidebuttons"
      "monitorcontrol"
      "hiddenbar"

      # Entertainment Tools
      "vlc"
      "jellyfin-media-player"

      # Productivity Tools
      "obsidian"

      # Browsers
      "google-chrome"

      # AI
      "lm-studio"
      "claude"

      # Misc
      "inkscape"
      "raspberry-pi-imager"
      "porting-kit"
      "balenaetcher"

      # Proton suite
      "proton-mail"
      "protonvpn"
      "proton-drive"
      "proton-pass"

      # work related stuff
      "mattermost"
      "microsoft-outlook"
      "microsoft-excel"
      "microsoft-word"
      "microsoft-teams"
    ];
  };
}
