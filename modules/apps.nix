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

    masApps = {
      Xcode = 497799835;
      "hidden-bar" = 1452453066;
      "mattermost" = 1614666244;
      "Microsoft Outlook" = 985367838;
      "DaVinci Resolve" = 571213070;
      # "Microsoft Word" = 462054704;
      # "Microsoft Excel" = 462058435;
    };

    taps = [
      "homebrew/cask-fonts"
      "homebrew/services"
      "homebrew/cask-versions"
    ];

    brews = [
      "kafka"
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
    ];
  };
}
