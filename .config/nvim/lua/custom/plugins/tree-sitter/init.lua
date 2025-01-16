return  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "java", "graphql", "typescript", "jq", "yaml", "json", "c", "cpp", "php", "tsx", "rust", "lua", "vim"  },
      auto_install = true,
      highlight = { enable = true },
      index = { enable = true }
    }
  }
