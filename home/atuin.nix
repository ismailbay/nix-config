{...}: {
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      sync_address = "https://sh.ismailbay.dev";
      sync_frequency = "5m";
    };
  };
}
