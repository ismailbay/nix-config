{
  config,
  pkgs,
  lib,
  ...
}: let
  name = "Ismail Bay";
  user = "ibay";
  email = "ismailbay@gmail.com";
in {
  # Shared shell configuration
  zsh = {
    enable = true;
    enableAutosuggestions = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "vscode"
        "terraform"
        "ansible"
        "kubectl"
        "gh"
        "last-working-dir"
      ];
    };

    initExtraFirst = ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      # Remove history data we don't want to see
      export HISTIGNORE="pwd:ls:cd"

      # Emacs is my editor
      export ALTERNATE_EDITOR=""
      export EDITOR="vim"
      export VISUAL="vim"

      # nix shortcuts
      shell() {
          nix-shell '<nixpkgs>' -A "$1"
      }

      # Use difftastic, syntax-aware diffing
      alias diff=difft

      # Always color ls and group directories
      alias ls='ls --color=auto'

      # Add Visual Studio Code (code)
      export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

      # nix does not provide sdkman package :/
      # THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
      export SDKMAN_DIR="/Users/charper/.sdkman"
      [[ -s "/Users/charper/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/charper/.sdkman/bin/sdkman-init.sh"
    '';
  };

  kitty = {
    enable = true;
    theme = "Solarized Darcula";
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

  starship = {
    enable = true;

    settings = {
      add_newline = false;
      battery.disabled = true;
      kubernetes.disabled = false;
    };
  };

  git = {
    enable = true;
    ignores = ["*.swp"];
    userName = name;
    userEmail = email;
    lfs = {
      enable = true;
    };
    extraConfig = {
      init.defaultBranch = "main";
      core = {
        editor = "vim";
        autocrlf = "input";
      };
      pull.rebase = true;
      rebase.autoStash = true;
    };
  };

  vim = {
    enable = true;
  };

  ssh = {
    enable = true;

    extraConfig = lib.mkMerge [
      ''
        Host 192.168.1.1
          HostKeyAlgorithms +ssh-rsa
          PubkeyAcceptedKeyTypes +ssh-rsa

        Host 192.168.1.2
          HostKeyAlgorithms +ssh-rsa
          PubkeyAcceptedKeyTypes +ssh-rsa

        Host git.ibay.dev
          User git
          Port 2222

        Host github.com
          Hostname github.com
          IdentitiesOnly yes
      ''
      (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
        ''
          IdentityFile /home/${user}/.ssh/id_github
        '')
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        ''
          IdentityFile /Users/${user}/.ssh/id_github
        '')
    ];
  };

  direnv = {
    enable = true;
  };

  tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      sensible
      yank
      prefix-highlight
      resurrect
      catppuccin
      #tmux-pomodoro-plus
    ];
    terminal = "screen-256color";
    escapeTime = 10;
    historyLimit = 50000;
    extraConfig = ''
      set -g default-terminal "xterm-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"
      set-option -g default-shell /run/current-system/sw/bin/zsh

      set -g base-index 1
      setw -g pane-base-index 1

      set -g set-titles-string ' #{pane_title} '
      set -g mouse on
      set-option -g visual-activity off
      set-option -g visual-bell off
      set-option -g visual-silence off
      set-window-option -g monitor-activity off

      set -g @catppuccin_flavour 'latte'
      # set -g status-right "#{pomodoro_status}"
    '';
  };

  k9s = {
    enable = true;
    plugin = {
      #--- Create debug container for selected pod in current namespace
      debug = {
        shortCut = "Shift-D";
        description = "Add debug container";
        scopes = ["containers"];
        command = "bash";
        background = false;
        confirm = true;
        args = [
          "-c"
          "kubectl debug -it -n=$NAMESPACE $POD --target=$NAME --image=nicolaka/netshoot:v0.11 --share-processes -- bash"
        ];
      };
    };
  };

  neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      {
        plugin = plenary-nvim;
        type = "lua";
      }
      {
        plugin = catppuccin-nvim;
        type = "lua";
        config = ''
          require("catppuccin").setup{
            {
              flavour = "mocha"
            }
          }
          vim.cmd[[colorscheme catppuccin-mocha]]
        '';
      }
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          local function metals_status()
            return vim.g["metals_status"] or ""
          end
          require('lualine').setup(
            {
              options = { theme = 'solarized_dark' },
              sections = {
                lualine_a = {'mode' },
                lualine_b = {'branch', 'diff' },
                lualine_c = {'filename', metals_status },
                lualine_x = {'encoding', 'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location'}
              }
            }
          )
        '';
      }
      {
        plugin = nvim-treesitter.withAllGrammars; # Syntax Highlighting
        type = "lua";
        config = ''
          require('nvim-treesitter.configs').setup {
            highlight = { enable = true}
          }
        '';
      }
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          local builtin = require('telescope.builtin')
          vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
          vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
          vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
          vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
          require("telescope").setup{}
        '';
      }
      {
        plugin = bufferline-nvim;
        type = "lua";
        config = ''
          require("bufferline").setup{}
        '';
      }
      {
        plugin = nvim-web-devicons;
        type = "lua";
        config = ''
          require("nvim-web-devicons").setup{}
        '';
      }
      {
        plugin = dashboard-nvim;
        type = "lua";
        config = ''
          require('dashboard').setup {}
        '';
      }
      vim-fugitive
    ];

    extraConfig = ''
      :set number
      :set expandtab
      set mouse=
      set clipboard+=unnamedplus
      set cursorlineopt=number
      if has("autocmd")
        au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
      endif
      au FileType css setlocal tabstop=2 shiftwidth=2
      au FileType haskell setlocal tabstop=2 shiftwidth=2
      au FileType nix setlocal tabstop=2 shiftwidth=2
      au FileType json setlocal tabstop=2 shiftwidth=2
      au FileType cpp setlocal tabstop=2 shiftwidth=2
      au FileType c setlocal tabstop=2 shiftwidth=2
      au FileType java setlocal tabstop=2 shiftwidth=2
      au FileType markdown setlocal spell
      au FileType markdown setlocal tabstop=2 shiftwidth=2
      au CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})
      au BufRead,BufNewFile *.wiki setlocal textwidth=80 spell tabstop=2 shiftwidth=2
      au FileType xml setlocal tabstop=2 shiftwidth=2
      au FileType help wincmd L
      au FileType gitcommit setlocal spell
    '';
    extraPackages = with pkgs; [
      ripgrep # Requirement for telescope
    ];
    # plugins = with pkgs.vimPlugins; [vim-airline vim-airline-themes vim-startify vim-tmux-navigator];
  };

  atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      sync_address = "https://sh.ismailbay.dev";
      sync_frequency = "5m";
    };
  };
}
