return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = { "williamboman/mason.nvim" },
  config = function()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "ts_ls",
        "eslint",
        "html",
        "bashls",
        "dockerls",
        "lua_ls",
        -- "graphql",
        -- "docker_compose_language_service",
        "tflint",
        "jsonls",
        "sqlls",
        "ruff",
        "terraformls",
        "yamlls",
        "intelephense",
      },
      automatic_installation = true,
    })
  end,
}
