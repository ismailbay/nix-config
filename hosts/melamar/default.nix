{
  config,
  pkgs,
  ...
}: let
  user = "ibay";
in {
  imports = [
    ../../modules/darwin/home-manager.nix
    ../../modules/shared
  ];

  # Auto upgrade nix package and the daemon service.
  services.nix-daemon.enable = true;

  # Setup user, packages, programs
  nix = {
    package = pkgs.nixUnstable;
    settings.trusted-users = ["@admin" "${user}"];

    gc = {
      user = "root";
      automatic = true;
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
      options = "--delete-older-than 30d";
    };

    # Turn this on to make command line easier
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  # Turn off NIX_PATH warnings now that we're using flakes
  system.checks.verifyNixPath = false;

  # Load configuration that is shared across systems
  environment.systemPackages = with pkgs;
    [
      vim
    ]
    ++ (import ../../modules/shared/packages.nix {inherit pkgs;});

  # Enable fonts dir
  fonts.fontDir.enable = true;

  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "FiraCode"
        "JetBrainsMono"
        "DroidSansMono"
        "SpaceMono"
        "RobotoMono"
        "BitstreamVeraSansMono"
      ];
    })
  ];

  system = {
    stateVersion = 4;

    defaults = {
      trackpad = {
        Clicking = true;
        TrackpadThreeFingerDrag = true;
      };
      finder = {
        FXDefaultSearchScope = "SCcf";
        AppleShowAllExtensions = true;
        FXEnableExtensionChangeWarning = false;
        FXPreferredViewStyle = "Nlsv";
        ShowStatusBar = true;
        ShowPathbar = false;
      };
      dock = {
        show-recents = false;
        tilesize = 48;
        orientation = "left";
      };
      NSGlobalDomain = {
        "com.apple.sound.beep.volume" = 0.000;
        InitialKeyRepeat = 13;
        KeyRepeat = 2;
      };
    };
  };

  # Add ability to used TouchID for sudo authentication
  security.pam.enableSudoTouchIdAuth = true;
}
