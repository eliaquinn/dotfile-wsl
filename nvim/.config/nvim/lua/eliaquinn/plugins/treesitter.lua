return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = { "windwp/nvim-ts-autotag" },
  init = function()
    -- GURANTEES NEOVIM MAPS `.prisma` FILES TO THE `prisma` FILETYPE
    vim.filetype.add({
      extension = {
        prisma = "prisma",
      },
    })
  end,
  config = function()
    require("nvim-treesitter.config").setup()

    local parsers = {
      "json", "javascript", "typescript", "tsx", "yaml", "html", "css", "prisma",
      "markdown", "markdown_inline", "svelte", "graphql", "hcl", "helm", "toml", "regex",
      "bash", "lua", "python", "vim", "dockerfile", "gitignore", "query", "terraform",
      "vimdoc", "c", "vue", "scss"
    }

    require("nvim-treesitter").install(parsers)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = parsers,
      callback = function(args)
        pcall(vim.treesitter.start, args.buf)
      end,
    })

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
