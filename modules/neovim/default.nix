{ pkgs, ... }: {
  programs.neovim =
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./plugins/lsp.lua;
      }

      {
        plugin = lightline-vim;
        config = toLuaFile ./plugins/lightline.lua;
      }
      vim-gitbranch

      { # Theme
      	plugin = catppuccin-nvim;
	      config = toLua ''
            require('catppuccin').setup({ transparent_background = true })
            vim.cmd[[colorscheme catppuccin-macchiato]]
	      '';
      }

      { # Nicer comments
        plugin = comment-nvim;
        config = toLua "require('Comment').setup()";
      }
      { # Autopair and highlight matching brackets {}
        plugin = nvim-autopairs;
        config = toLua "require('nvim-autopairs').setup {}";
      }
      {
        plugin = guess-indent-nvim;
        config = toLua "require('guess-indent').setup {}";
      }

      { # Code completion
        plugin = nvim-cmp;
        config = toLuaFile ./plugins/cmp.lua;
      }
      luasnip
      cmp_luasnip
      friendly-snippets
      cmp-nvim-lsp

      { # Telescope
        plugin = telescope-nvim;
        config = toLuaFile ./plugins/telescope.lua;
      }
      telescope-fzf-native-nvim

      { # Treesitter
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
          p.tree-sitter-c
          p.tree-sitter-rust
        ]));
        config = toLuaFile ./plugins/treesitter.lua;
      }

      { # Git staging
        plugin = gitsigns-nvim;
        config = toLuaFile ./plugins/gitsigns.lua;
      }

      markdown-preview-nvim
    ];

    # Default language server packages
    extraPackages = with pkgs; [
      # luajitPackages.lua-lsp
      nil
      clang-tools
      rust-analyzer rustfmt
      python312Packages.python-lsp-server
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./options.lua}
    '';
  };
  home.shellAliases.v = "nvim";
  home.shellAliases.vdiff = "nvim $(git status --porcelain | awk '{print $2}')";
  programs.git.extraConfig.merge.tool = "nvimdiff";

  # Default language servers (more can be added by appending language servers to LSP_PATH)
  programs.zsh.sessionVariables.LSP_PATH = "nil_ls:clangd:pylsp:rust_analyzer";

  # Clangd C-only config
  home.file.".config/clangd/config.yaml".text = ''CompileFlags:
    Add: [-xc]
  '';
}
