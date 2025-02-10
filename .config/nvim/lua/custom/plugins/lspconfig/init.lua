return {
  -- {'hrsh7th/cmp-nvim-lsp'},
  -- {'hrsh7th/nvim-cmp'},
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "custom.configs.lspconfig"
    end,
  }
}
