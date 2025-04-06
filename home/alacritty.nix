{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 14;
        normal.family = "FiraCode Nerd Font Mono";
      };

      terminal.shell = {
        args = ["new-session" "-A" "-D" "-s" "main"];
        program = "${pkgs.tmux}/bin/tmux";
      };
    };
  };
}
