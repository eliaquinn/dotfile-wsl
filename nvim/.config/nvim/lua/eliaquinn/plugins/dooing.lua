return {
  "atiladefreitas/dooing",
  config = function()
    require("dooing").setup({
      ui = { style = "modern", tree_connectors = false },
      window = {
        dimensions = function()
          return {
            width = math.max(40, math.floor(vim.o.columns * 0.4)),
            height = math.max(10, math.floor(vim.o.lines * 0.6)),
          }
        end,
      },
      per_project = {
        enabled = true,               -- Enable/disable per-project todos
        default_filename = "dooing.json", -- Default filename for new project todo files
        auto_gitignore = false,       -- Automatically add to .gitignore
        -- Set to true for auto-add, "prompt" to ask, false to skip
        on_missing = "prompt",        -- What to do when project todo file doesn't exist
        -- "prompt" = ask user, "auto_create" = create automatically
        auto_open_project_todos = false, -- Auto-open project todos on startup if they exist
        -- Opens window automatically when entering a git project with todos
      }
    })

    vim.api.nvim_set_hl(0, "DooingSectionTitle", { fg = "#89b4fa", bold = true })
    vim.api.nvim_set_hl(0, "DooingOverdue", { fg = "#f38ba8" })
  end,
}
