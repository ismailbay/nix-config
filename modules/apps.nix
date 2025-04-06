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
      "reMarkable" = 1276493162;
      "mattermost" = 1614666244;
      "Microsoft Outlook" = 985367838;
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
      "docker"
      "zed"
      "headlamp"

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
      "brave-browser"
      "google-chrome"

      # AI
      "lm-studio"

      # Misc
      "inkscape"
      "raspberry-pi-imager"
    ];
  };
}
