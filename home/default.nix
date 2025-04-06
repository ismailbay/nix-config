{
  username,
  ...
}: {
  imports = [
    ./shell.nix
    ./core.nix
    ./git.nix
    ./starship.nix
    ./ssh.nix
    ./direnv.nix
    ./tmux.nix
    ./k9s.nix
    ./neovim.nix
    ./atuin.nix
    ./fzf.nix
    ./alacritty.nix
  ];

  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;
}
