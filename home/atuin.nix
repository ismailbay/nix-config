{...}: {
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      sync_address = "https://sh.ibay.dev";
      sync_frequency = "15m";
    };
  };
}
