local plugins = {
  {
    "nvim-lua/plenary.nvim",
    lazy = false
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint-lsp",
        "js-debug-adapter",
        "prettier",
        "typescript-language-server",
        "jdtls"
      }
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = { "java", "graphql", "typescript", "jq", "yaml", "json", "c", "cpp", "php", "tsx", "rust", "lua", "vim"  },
      auto_install = true,
      highlight = { enable = true },
      index = { enable = true }
    }
  },
  -- {
  -- 'nvim-java/nvim-java',
  --   dependencies = {
  --     'nvim-java/lua-async-await',
  --     'nvim-java/nvim-java-core',
  --     'nvim-java/nvim-java-test',
  --     'nvim-java/nvim-java-dap',
  --     'MunifTanjim/nui.nvim',
  --     'neovim/nvim-lspconfig',
  --     'mfussenegger/nvim-dap',
  --     {
  --       'williamboman/mason.nvim',
  --       opts = {
  --         registries = {
  --           'github:nvim-java/mason-registry',
  --           'github:mason-org/mason-registry',
  --         },
  --       },
  --     }
  --   },
  -- },
  {
    "neovim/nvim-lspconfig",
    opts ={
      setup = {
        jdtls = function ()
          return true
        end
      }
    },
    config = function()
      require("plugins.configs.lspconfig")
      require("custom.configs.lspconfig")
    end
  },
  {
    "eatgrass/maven.nvim",
    cmd = { "Maven", "MavenExec" },
    dependencies = "nvim-lua/plenary.nvim",
    config = function()
      require('maven').setup({
        executable="mvn"
      })
    end
  },
  { "mfussenegger/nvim-jdtls" }
}

return plugins
