return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  priority = 100,
  build = ":TSUpdate",
  dependencies = { "windwp/nvim-ts-autotag" },
  init = function()
    -- GURANTEES NEOVIM MAPS `.prisma` FILES TO THE `prisma` FILETYPE
    vim.filetype.add({
      extension = {
        prisma = "prisma",
      },
    })

    -- Tentar adicionar tree-sitter-cli ao PATH (caminhos comuns)
    local ts_paths = {
      "/home/linuxbrew/.linuxbrew/bin",
      "/usr/local/bin",
      "/usr/bin",
      vim.fn.expand("~/.npm-global/bin"),
    }
    for _, p in ipairs(ts_paths) do
      if vim.fn.glob(p .. "/tree-sitter") ~= "" then
        vim.env.PATH = vim.env.PATH .. ":" .. p
        break
      end
    end

    -- Ativar Treesitter highlighting para prisma
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "prisma",
      callback = function(args)
        vim.treesitter.start(args.buf)
      end,
    })
  end,
  config = function()
    require("nvim-treesitter.config").setup({
      install_dir = vim.fn.stdpath("data") .. "/site", -- Diretório correto para parsers
      highlight = {
        enable = true,
        disable = {},
      },
      indent = {
        enable = true,
      },
      ensure_installed = {
        "json", "javascript", "typescript", "tsx", "yaml", "html", "css", "prisma",
        "markdown", "markdown_inline", "svelte", "graphql", "hcl", "helm", "toml", "regex",
        "bash", "lua", "python", "vim", "dockerfile", "gitignore", "query", "terraform",
        "vimdoc", "c", "vue", "scss", "php"
      },
      auto_install = true,
      sync_install = false,
    })

    -- Instalar parser prisma automaticamente se necessário
    local function ensure_prisma_parser()
      local parser_path = vim.fn.stdpath("data") .. "/site/parser/prisma.so"
      if vim.fn.glob(parser_path) ~= "" then
        return
      end

      local ts_cmd = vim.fn.globpath(vim.env.PATH, "tree-sitter")
      if ts_cmd == "" then
        return
      end

      local tmp_dir = vim.fn.stdpath("data") .. "/tmp/ts-prisma"
      vim.fn.system({
        "bash", "-c",
        string.format(
          "rm -rf %s && git clone --depth 1 https://github.com/victorhqc/tree-sitter-prisma.git %s && cd %s && tree-sitter generate && tree-sitter build -o %s/prisma.so && mkdir -p %s/site/parser && cp %s/prisma.so %s/site/parser/ && mkdir -p %s/site/queries/prisma && cp %s/queries/*.scm %s/site/queries/prisma/",
          tmp_dir, tmp_dir, tmp_dir, tmp_dir, vim.fn.stdpath("data"), tmp_dir, vim.fn.stdpath("data"), vim.fn.stdpath("data"), tmp_dir, vim.fn.stdpath("data")
        )
      })
    end

    -- Executar após um pequeno delay
    vim.defer_fn(ensure_prisma_parser, 500)

    require("nvim-ts-autotag").setup({
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      }
    })
  end,
}

-- return {
--   "nvim-treesitter/nvim-treesitter",
--   event = { "BufReadPre", "BufNewFile" },
--   build = ":TSUpdate",
--   dependencies = { "windwp/nvim-ts-autotag" },
--   config = function()
--     require("nvim-treesitter.config").setup({
--       highlight = {
--         enable = true,
--         additional_vim_regex_highlighting = { "terraform" },
--         disable = { "tmux" },
--       },
--       indent = { enable = true },
--       autotag = { enable = true },
--       ensure_installed = {
--         "json", "javascript", "typescript", "tsx", "yaml", "html", "css", "prisma",
--         "markdown", "markdown_inline", "svelte", "graphql", "hcl", "helm", "toml", "regex",
--         "bash", "lua", "python", "vim", "dockerfile", "gitignore", "query", "terraform",
--         "vimdoc", "c", "tmux", "vue", "vue_postcss", "scss"
--       },
--       auto_install = true,
--       sync_install = false,
--     })
--   end,
-- }
