local plugins = {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint-lsp",
        "js-debug-adapter",
        "prettier",
        "typescript-language-server",
        "nvim-java/nvim-java",
      }
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("plugins.configs.lspconfig")
      require("custom.configs.lspconfig")
    end
  },
  {
    "nvim-java/nvim-java",
    config = false,
    dependencies = {
      {
        "neovim/nvim-lspconfig",
        opts = {
          servers = {
            -- Your JDTLS configuration goes here
            jdtls = {
              -- settings = {
              --   java = {
              --     configuration = {
              --       runtimes = {
              --         {
              --           name = "JavaSE-23",
              --           path = "/usr/local/sdkman/candidates/java/23-tem",
              --         },
              --       },
              --     },
              --   },
              -- },
            },
          },
          setup = {
            jdtls = function()
              -- Your nvim-java configuration goes here
              require("java").setup({
                -- root_markers = {
                --   "settings.gradle",
                --   "settings.gradle.kts",
                --   "pom.xml",
                --   "build.gradle",
                --   "mvnw",
                --   "gradlew",
                --   "build.gradle",
                --   "build.gradle.kts",
                -- },
              })
            end,
          },
        },
      },
    },
  }
}

return plugins
