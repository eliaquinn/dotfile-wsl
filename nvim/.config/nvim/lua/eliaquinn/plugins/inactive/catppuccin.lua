return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  lazy = false,
  config = function()
    require("catppuccin").setup({
      flavour = "frappe",
      background = {
        dark = "frappe",
        light = "latte",
      },
      compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
      compile = {
        enabled = false,
        path = vim.fn.stdpath("cache") .. "/catppuccin",
      },
      color_overrides = {
        latte = {
          rosewater = "#dc8a78",
          flamingo = "#dd7878",
          pink = "#ea76cb",
          mauve = "#8839ef",
          red = "#d20f39",
          maroon = "#e64553",
          peach = "#fe640b",
          yellow = "#df8e1d",
          green = "#40a02b",
          teal = "#179299",
          sky = "#04a5e5",
          sapphire = "#209fb5",
          blue = "#1e66f5",
          lavender = "#7287fd",
          text = "#4c4f69",
          subtext1 = "#5c5f77",
          subtext0 = "#6c6f85",
          overlay2 = "#7c7f93",
          overlay1 = "#8c8fa1",
          overlay0 = "#9ca0b0",
          surface2 = "#acb0be",
          surface1 = "#bcc0cc",
          surface0 = "#ccd0da",
          base = "#eff1f5",
          mantle = "#e6e9ef",
          crust = "#dce0e8",
        }
      },
      custom_highlights = function(colors)
        return {
          Normal = { bg = colors.base },
          NormalFloat = { bg = colors.mantle },
          CursorLine = { bg = colors.surface0 },
          LineNr = { fg = colors.overlay0 },
          CursorLineNr = { fg = colors.mauve, style = { "bold" } },
        }
      end,
      integrations = {
        cmp = true,
        gitsigns = true,
        lualine = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
      },
    })

    vim.o.background = "dark"

    local ok, err = pcall(vim.cmd.colorscheme, "catppuccin")
    if not ok then
      vim.notify("Erro ao carregar Catppuccin: " .. tostring(err), vim.log.levels.WARN)
      vim.cmd.colorscheme("default")
    end
  end,
}
