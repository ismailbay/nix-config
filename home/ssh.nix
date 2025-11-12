{username, ...}: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    matchBlocks."*" = {
      forwardAgent = false;
      # "a private key that is used during authentication will be added to ssh-agent if it is running"
      addKeysToAgent = "yes";
      compression = true;
      serverAliveInterval = 0;
      serverAliveCountMax = 3;
      hashKnownHosts = false;
      userKnownHostsFile = "~/.ssh/known_hosts";
      controlMaster = "no";
      controlPath = "~/.ssh/master-%r@%n:%p";
      controlPersist = "no";
    };

    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        identityFile = "/Users/${username}/.ssh/id_github";
        identitiesOnly = true;
      };

      "192.168.*" = {
        forwardAgent = true;
        identityFile = "/Users/${username}/.ssh/id_ed25519";
        identitiesOnly = true;
      };
    };
  };
}
