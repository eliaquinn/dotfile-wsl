return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.HINT] = "󰰀",
          [vim.diagnostic.severity.INFO] = "",
        },
      },
    })

    local on_attach = function(_, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    end

    -- Path do Vue Language Server instalado pelo Mason
    local vue_language_server_path = vim.fn.expand('$MASON/packages') ..
    '/vue-language-server/node_modules/@vue/language-server'

    -- Configuração do TypeScript com suporte a Vue
    vim.lsp.config.ts_ls = {
      capabilities = capabilities,
      on_attach = on_attach,
      init_options = {
        plugins = {
          {
            name = '@vue/typescript-plugin',
            location = vue_language_server_path,
            languages = { 'vue' },
          },
        },
      },
      filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    }

    -- Configuração do Vue Language Server
    vim.lsp.config.vue_ls = {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- Configuração do Pyright
    vim.lsp.config.pyright = {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    -- Configuração do Lua LS
    vim.lsp.config.lua_ls = {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          completion = {
            callSnippet = "Replace",
          },
          diagnostics = { globals = { "vim" } },
          workspace = {
            checkThirdParty = false,
            library = vim.api.nvim_get_runtime_file("", true),
          },
          telemetry = { enable = false },
        },
      },
    }

    -- Configuração do ESLint
    vim.lsp.config.eslint = {
      capabilities = capabilities,
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)

        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            pcall(vim.cmd, "EslintFixAll")
          end,
        })
      end,
    }

    -- Configuração do Intelephense (PHP)
    vim.lsp.config.intelephense = {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        intelephense = {
          files = {
            maxSize = 5000000, -- 5MB - para projetos PHP maiores
          },
          stubs = {
            "apache2",
            "bcmath",
            "bz2",
            "calendar",
            "com_dotnet",
            "Core",
            "ctype",
            "curl",
            "date",
            "dba",
            "dom",
            "enchant",
            "exif",
            "fileinfo",
            "filter",
            "fpm",
            "ftp",
            "gd",
            "hash",
            "iconv",
            "imap",
            "influxdb",
            "intl",
            "json",
            "ldap",
            "libxml",
            "mbstring",
            "mcrypt",
            "memcached",
            "mysqli",
            "oci8",
            "odbc",
            "openssl",
            "pcntl",
            "pcre",
            "pdo",
            "pgsql",
            "posix",
            "pspell",
            "readline",
            "recode",
            "redis",
            "Reflection",
            "session",
            "shmop",
            "SimpleXML",
            "snmp",
            "soap",
            "sockets",
            "sodium",
            "SPL",
            "standard",
            "superglobals",
            "sysvmsg",
            "sysvsem",
            "sysvshm",
            "tidy",
            "tokenizer",
            "xml",
            "xmlreader",
            "xmlrpc",
            "xmlwriter",
            "xsl",
            "zlib",
            "wordpress",
            "phpunit",
          },
          diagnostics = {
            enable = true,
          },
        },
      },
    }

    -- Configuração do Prisma Language Server
    vim.lsp.config.prismals = {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        prisma = {
          prismaFmt = {
            indentSize = 2,
          },
        },
      },
    }

    -- Habilitar todos os LSPs
    vim.lsp.enable({ "ts_ls", "eslint", "pyright", "lua_ls", "vue_ls", "intelephense", "prismals" })
  end,
}
