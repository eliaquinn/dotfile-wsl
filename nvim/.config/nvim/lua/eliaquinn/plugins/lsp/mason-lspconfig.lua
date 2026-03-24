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
        "tflint",
        "jsonls",
        "sqlls",
        "ruff",
        "terraformls",
        "yamlls",
        "intelephense",
        "vue_ls",
        "cssls",
        "tailwindcss"
      },
      automatic_installation = true,
    })
  end,
}
