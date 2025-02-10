local nvlsp = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"

nvlsp.defaults() -- load nvchad's defaults

local servers = {
  "html",
  "lua",
  "cssls",
  -- TypeScript
  "ts_ls"
}

-- initialize all lsp servers dynamically
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities
  }
end

-- OLD CONFIGS BELOW 
-- -- Reserve a space in the gutter
  -- -- This will avoid an annoying layout shift in the screen
  -- vim.opt.signcolumn = 'yes'
  --
  -- -- Add cmp_nvim_lsp capabilities settings to lspconfig
  -- -- This should be executed before you configure any language server
  -- local lspconfig_defaults = require('lspconfig').util.default_config
  -- lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  --   'force',
  --   lspconfig_defaults.capabilities,
  --   require('cmp_nvim_lsp').default_capabilities()
  -- )
  --
  -- require('lspconfig').jdtls.setup((function()
  --   print('lspconf is being loaded')
  --   -- FYI!: java/nvim-java needs to be setup before jdtls
  --   require('java').setup(require('custom.opts.java'))
  --   return require('custom.opts.lsp.jdtls')
  -- end)())
