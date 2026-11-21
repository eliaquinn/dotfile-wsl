return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      vue = { "eslint_d" },
      python = { "ruff" },
      php = { "php" }, -- PHP syntax check
      rust = { "clippy" },
    }

    local severities = {
      error = vim.diagnostic.severity.ERROR,
      warning = vim.diagnostic.severity.WARN,
      note = vim.diagnostic.severity.INFO,
      help = vim.diagnostic.severity.HINT,
    }

    -- Linter customizado do clippy.
    --
    -- O `cargo clippy` reporta tanto os lints do clippy quanto os do rustc,
    -- que já são exibidos pelo rust-analyzer. Aqui ficam apenas os lints do
    -- clippy (`clippy::`), evitando diagnósticos duplicados.
    lint.linters.clippy = {
      cmd = "cargo",
      args = { "clippy", "--message-format=json" },
      stdin = false,
      append_fname = false,
      -- O cargo sai com código diferente de zero quando há erros de compilação,
      -- que já são reportados pelo rust-analyzer.
      ignore_exitcode = true,
      parser = function(output, bufnr)
        local diagnostics = {}
        local buffer_path = vim.api.nvim_buf_get_name(bufnr)

        --- Verifica se o arquivo reportado pelo cargo é o buffer atual.
        --- O cargo informa os caminhos relativos à raiz do workspace, enquanto
        --- o buffer sempre traz o caminho absoluto.
        ---@param file_name string?
        ---@return boolean
        local function is_current_file(file_name)
          if type(file_name) ~= "string" or file_name == "" then
            return false
          end

          local name = file_name:gsub("\\", "/")
          local path = buffer_path:gsub("\\", "/")

          if path == name then
            return true
          end

          return path:sub(-#name) == name and path:sub(-(#name + 1), -(#name + 1)) == "/"
        end

        --- Converte a mensagem do cargo em diagnósticos do Neovim.
        ---@param message table
        ---@param from_clippy boolean `true` quando a mensagem é filha de um lint do clippy
        local function collect(message, from_clippy)
          -- O json do cargo usa `null` em campos opcionais, que o Neovim
          -- representa como vim.NIL.
          if type(message) ~= "table" then
            return
          end

          local code = type(message.code) == "table" and message.code.code or nil
          local is_clippy = type(code) == "string" and code:find("^clippy::") ~= nil

          if is_clippy then
            from_clippy = true
          end

          if from_clippy then
            local spans = type(message.spans) == "table" and message.spans or {}

            for _, span in ipairs(spans) do
              if type(span) == "table" and span.is_primary == true and is_current_file(span.file_name) then
                table.insert(diagnostics, {
                  lnum = span.line_start - 1,
                  end_lnum = span.line_end - 1,
                  col = span.column_start - 1,
                  end_col = span.column_end - 1,
                  severity = severities[message.level] or vim.diagnostic.severity.WARN,
                  source = "clippy",
                  code = code,
                  message = message.message,
                })
              end
            end
          end

          local children = type(message.children) == "table" and message.children or {}

          for _, child in ipairs(children) do
            collect(child, from_clippy)
          end
        end

        for _, line in ipairs(vim.split(output, "\n")) do
          if line ~= "" then
            local ok, item = pcall(vim.json.decode, line)

            if ok and type(item) == "table" and item.reason == "compiler-message" then
              collect(item.message, false)
            end
          end
        end

        return diagnostics
      end,
    }

    local grp = vim.api.nvim_create_augroup("linting", { clear = true })

    --- Executa o linter adequado para o buffer atual.
    --- O cargo precisa rodar na raiz do projeto, por isso o clippy usa o
    --- diretório do Cargo.toml mais próximo.
    local function lint_buffer()
      if vim.bo.filetype == "rust" then
        local root = vim.fs.root(0, { "Cargo.toml" })

        if not root then
          return
        end

        lint.try_lint(nil, { cwd = root })
        return
      end

      lint.try_lint()
    end

    -- O `cargo clippy` recompila o crate e é bem mais lento que os demais
    -- linters, então em arquivos Rust ele roda apenas ao salvar.
    vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
      group = grp,
      callback = function()
        if vim.bo.filetype ~= "rust" then
          lint.try_lint()
        end
      end,
    })

    vim.api.nvim_create_autocmd("BufWritePost", {
      group = grp,
      callback = lint_buffer,
    })

    vim.keymap.set("n", "<leader>l", function()
      lint_buffer()
    end, { desc = "Lint current file" })
  end,
}
