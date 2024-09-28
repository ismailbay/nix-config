{...}: {
  programs.kitty = {
    enable = true;
    themeFile = "Solarized_Darcula";
    shellIntegration = {
      enableZshIntegration = true;
    };
    extraConfig = ''
      adjust_line_height 105%
      font_family FiraCode Nerd Font Mono
      font_size 14.0
      confirm_os_window_close 0
    '';
  };
}
