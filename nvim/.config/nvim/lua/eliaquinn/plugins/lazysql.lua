return {
  {
    "LostbBlizzard/lazysql.nvim",
    dependencies = { "MunifTanjim/nui.nvim" },
    opts = {}, -- chama automaticamente: require("lazysql").setup()
    -- ou, se preferir explícito:
    -- config = function() require("lazysql").setup() end,
    keys = {
      { "<leader>lq", "<cmd>LazySql<CR>", desc = "Toggle LazySql" },
    },
  },
}
