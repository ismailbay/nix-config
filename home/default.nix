{
  username,
  ...
}: {
  imports = [
    ./shell.nix
    ./core.nix
    ./git.nix
    ./starship.nix
    ./kitty.nix
    ./ssh.nix
    ./direnv.nix
    ./tmux.nix
    ./k9s.nix
    ./neovim.nix
    ./atuin.nix
    ./fzf.nix
  ];

  home = {
    username = username;
    homeDirectory = "/Users/${username}";
    stateVersion = "23.11";
  };

  programs.home-manager.enable = true;
}
