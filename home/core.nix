{pkgs, ...}: {
  home.packages = with pkgs; [
    age
    alejandra
    argocd
    ansible
    ansible-lint
    btop
    cilium-cli
    cloudflared
    coreutils
    delta
    difftastic
    direnv
    # docker-buildx
    # docker-client
    # docker-credential-helpers
    fastfetch
    fluxcd
    gh
    git
    gnupg
    go
    go-task
    gradle
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
    lazydocker
    meslo-lgs-nf
    minikube
    minio-client
    moreutils
    # neovim
    openconnect
    openssh
    openssl
    opentofu
    pre-commit
    python3
    quarkus
    ripgrep
    sops
    stern
    talosctl
    terraform
    terramate
    tldr
    tmux
    tree
    unrar
    unzip
    watch
    wget
    yq-go
    zsh
  ];
}
