{...}: {
  programs.starship = {
    enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;

    settings = {
      add_newline = false;
      battery.disabled = true;
      terraform.disabled = false;
      kubernetes.disabled = false;
    };
  };
}
