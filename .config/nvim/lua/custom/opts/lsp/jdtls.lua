local masonPath = os.getenv('HOME').."/.local/share/nvim/packages"
local lombokJarPath = masonPath .. "/lombok-nightly/lombok.jar"
local jdtlsPath = masonPath .. '/jdtls'
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local jdtlsData = "/Library/Preferences/jdtls/"..project_name

local function getJdkBinPath(jdkBrewPkgName)
  return "/Library/Java/JavaVirtualMachines/" .. jdkBrewPkgName .. ".jdk/Contents/Home"
end


return {
  -- See for config options: https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line
  cmd = {
    "java",
    "--version",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. lombokJarPath,
    "-Xmx1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",

    "-jar",
    vim.fn.glob(jdtlsPath .. "/plugins/org.eclipse.equinox.launcher.jar", true),

    "-configuration",
    jdtlsPath .. "/config_mac_arm",

    "-data",
    jdtlsData,
  },
  setings = {
    java = {
      configuration = {
        home = getJdkBinPath('temurin-21'),
        runtimes = {
          {
            name = "JavaSE-21",
            path = getJdkBinPath('temurin-21'),
            default = true
          },
          -- {
          --   name = "JavaSE-17",
          --   path = getJdkBinPath('temurin-17'),
          -- },
        },
        maven = {
          downloadSources = true,
          updateSnapshots = true,
         },
        referencesCodeLens = {
          enabled = true,
        },
        references = {
          includeDecompiledSources = true,
        },
        -- TODO: update to use intellij formatting
        format = {
          enabled = false,
        },
        inlayHints = {
          parameterNames = {
            enabled = 'all', -- literals, all, none
          },
        },
      },
    },
      signatureHelp = { enabled = true },
      -- -- extendedClientCapabilities = extendedClientCapabilities,
      -- completion = {
      --   favoriteStaticMembers = {
      --       "org.hamcrest.MatcherAssert.assertThat",
      --       "org.hamcrest.Matchers.*",
      --       "org.hamcrest.CoreMatchers.*",
      --       "org.junit.jupiter.api.Assertions.*",
      --       "java.util.Objects.requireNonNull",
      --       "java.util.Objects.requireNonNullElse",
      --       "org.mockito.Mockito.*",
      --   },
      -- },
    }
}


