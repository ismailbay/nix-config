{pkgs, ...}: {
  programs.neovim = {
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
  };
}
