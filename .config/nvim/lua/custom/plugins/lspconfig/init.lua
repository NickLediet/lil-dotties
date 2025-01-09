-- local config = require("plugins.configs.lspconfig")
-- local on_attach = config.on_attach
-- local capabilities = config.capabilities
--
-- require('java').setup()
-- local lspconfig = require("lspconfig")
--
-- local function organize_imports()
--   local params = {
--     command = "_typescript.organizeImports",
--     arguments = {vim.api.nvim_buf_get_name(0)},
--   }
--   vim.lsp.buf.execute_command(params)
-- end
--
-- lspconfig.tsserver.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   init_options = {
--     preferences = {
--       disableSuggestions = true,
--     }
--   },
--   commands = {
--     OrganizeImports = {
--       organize_imports,
--       description = "Organize Imports",
--     }
--   }
-- }
-- local function getJdkBinPath(jdkBrewPkgName)
--   return "/Library/Java/JavaVirtualMachines/" .. jdkBrewPkgName .. ".jdk/Contents/Home"
-- end
--
-- local extendedClientCapabilities = lspconfig.jdtls.extendedClientCapabilities
--
-- lspconfig.jdtls.setup({
--   -- root_dir = require('jdtls.setup').find_root { '.git', 'mvnw', 'gradlew', 'pom.xml', 'build.gradle' },
--   java = {
--     configuration =  {
--       runtimes = {
--         {
--           name = "JavaSE-21",
--           path = getJdkBinPath('temurin-21'),
--           default = true
--         },
--         {
--           name = "JavaSE-17",
--           path = getJdkBinPath('temurin-17'),
--           default = false
--         },
--       },
--     },
--     signatureHelp = { enabled = true },
--     extendedClientCapabilities = extendedClientCapabilities,
--     maven = {
--       downloadSources = true,
--     },
--     referencesCodeLens = {
--       enabled = true,
--     },
--     references = {
--       includeDecompiledSources = true,
--     },
--     inlayHints = {
--       parameterNames = {
--         enabled = 'all', -- literals, all, none
--       },
--     },
--     format = {
--       enabled = false,
--     }
--   }
-- })
return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      require("plugins.configs.lspconfig")
      -- require("custom.configs.lspconfig")
      -- TODO: move opts tables to opts modules
      -- JDTLS CONFIG
      table.insert(opts.servers.jdtls, require('custom.opts.lsp.jdtls')

      table.insert(opts.setup, function()
        print("Calling opts.setup from 'neovim/nvim-lspconfig'")
        require('java').setup(require('custom.opts.java'))
      end)
    end,
  }
}
