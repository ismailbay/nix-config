{pkgs, ...}: {
  home.packages = with pkgs; [
    age
    alejandra
    argocd
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
    krew
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
    telepresence2
    terraform
    tldr
    tmux
    tree
    unrar
    unzip
    watch
    wget
    yarn
    yq-go
    zsh
  ];
}
