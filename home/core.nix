{pkgs, ...}: {
  home.packages = with pkgs; [
    age
    alejandra
    # ansible
    # ansible-lint
    btop
    cloudflared
    coreutils
    direnv
    docker-client
    fluxcd
    git
    gnupg
    go
    go-task
    htop
    iftop
    inetutils
    jq
    k0sctl
    kind
    kubeconform
    kubectl
    kubernetes-helm
    kubeseal
    kustomize
    moreutils
    meslo-lgs-nf
    neofetch
    # neovim
    nodejs_20
    openssh
    nodePackages_latest.pnpm
    pre-commit
    pwgen
    python3
    ripgrep
    sops
    stern
    talosctl
    terraform
    tldr
    tmux
    tree
    unrar
    unzip
    watch
    wget
    yarn
    yq
    zsh
  ];
}
