{username, ...}: {
  programs.ssh = {
    enable = true;

    extraConfig = ''
      Host 192.168.1.1
        HostKeyAlgorithms +ssh-rsa
        PubkeyAcceptedKeyTypes +ssh-rsa

      Host github.com
        Hostname github.com
        IdentitiesOnly yes
        IdentityFile /Users/${username}/.ssh/id_github
    '';
  };
}
