return {
  "atiladefreitas/dooing",
  config = function()
    require("dooing").setup({
      save_path = vim.fn.stdpath("data") .. "/dooing_todos.json",
      pretty_print_json = false, -- Pretty-print JSON output (requires jq or python)
      timestamp = {
        enabled = true,          -- Show relative timestamps (e.g., @5m ago, @2h ago)
      },

      ui = {
        style = "modern",
        sections = true,        -- group top-level todos under status headings
        priority_bar = true,    -- colored marker instead of coloring the whole row
        tree_connectors = true, -- draw ├─ / └─ / │ guides for nested tasks
        note_preview = true,    -- first line of a todo's notes, dimmed, beneath it
        progress = true,
        section_titles = {
          in_progress = "Em Progresso",
          pending = "Pendente",
          done = "Concluída",
        },
        icons = {
          priority_bar = "▎",
          overdue = "󰀦",
          progress_on = "▰",
          progress_off = "▱",
        },
      },
      window = {
        dimensions = function()
          return {
            width = math.max(40, math.floor(vim.o.columns * 0.4)),
            height = math.max(10, math.floor(vim.o.lines * 0.6)),
          }
        end,
      },
      formatting = {
        pending = {
          icon = "○",
          format = { "icon", "notes_icon", "text", "due_date", "ect" },
        },
        in_progress = {
          icon = "◐",
          format = { "icon", "text", "due_date", "ect" },
        },
        done = {
          icon = "✓",
          format = { "icon", "notes_icon", "text", "due_date", "ect" },
        },
      },
      per_project = {
        enabled = true,                   -- Enable per-project todos
        default_filename = "dooing.json", -- Default filename for project todos
        auto_gitignore = false,           -- Auto-add to .gitignore (true/false/"prompt")
        on_missing = "prompt",            -- What to do when file missing ("prompt"/"auto_create")
        auto_open_project_todos = false,  -- Auto-open project todos on startup if they exist
      },
    })

    vim.api.nvim_set_hl(0, "DooingSectionTitle", { fg = "#89b4fa", bold = true })
    vim.api.nvim_set_hl(0, "DooingOverdue", { fg = "#f38ba8" })
  end,
}
