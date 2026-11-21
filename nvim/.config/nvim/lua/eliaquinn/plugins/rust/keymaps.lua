-- Atalhos do Rust baseados nas APIs do rust-analyzer.
--
-- O rust-analyzer não expõe "run test" como code action: os runnables são
-- obtidos via `experimental/runnables` e a execução fica a cargo do cliente.
local M = {}

--- Recupera o cliente do rust-analyzer conectado ao buffer atual.
---@return vim.lsp.Client?
local function rust_analyzer_client()
  return vim.lsp.get_clients({ name = "rust_analyzer", bufnr = 0 })[1]
end

--- Monta os parâmetros de posição usados pelas APIs do rust-analyzer.
---@return table
local function position_params()
  local cursor = vim.api.nvim_win_get_cursor(0)

  return {
    textDocument = { uri = vim.uri_from_bufnr(0) },
    position = { line = cursor[1] - 1, character = cursor[2] },
  }
end

--- Converte um runnable em uma lista de argumentos executável.
---@param runnable table
---@return string[]
local function runnable_command(runnable)
  local args = runnable.args or {}
  local cmd = {}

  if runnable.kind == "shell" then
    cmd = { args.program or "sh" }
    vim.list_extend(cmd, args.args or {})
    return cmd
  end

  cmd = { args.overrideCargo or "cargo" }
  vim.list_extend(cmd, args.cargoArgs or {})

  -- Os argumentos do binário de teste vão depois do separador do cargo.
  local executable_args = vim.tbl_filter(function(arg)
    return arg ~= ""
  end, args.executableArgs or {})

  if #executable_args > 0 then
    cmd[#cmd + 1] = "--"
    vim.list_extend(cmd, executable_args)
  end

  return cmd
end

--- Executa o runnable escolhido em um terminal.
---@param runnable table
local function execute_runnable(runnable)
  local args = runnable.args or {}

  vim.cmd("belowright split")
  vim.fn.jobstart(runnable_command(runnable), {
    term = true,
    cwd = args.cwd or vim.fn.getcwd(),
    env = args.environment,
  })
end

--- Executa o teste (ou módulo de testes) sob o cursor.
local function run_test()
  local client = rust_analyzer_client()

  if not client then
    vim.notify("rust-analyzer não está ativo neste buffer", vim.log.levels.WARN)
    return
  end

  client:request("experimental/runnables", position_params(), function(err, runnables)
    if err then
      vim.notify("rust-analyzer: " .. tostring(err.message), vim.log.levels.ERROR)
      return
    end

    local tests = vim.tbl_filter(function(runnable)
      return type(runnable.label) == "string" and runnable.label:lower():find("^test") ~= nil
    end, runnables or {})

    if #tests == 0 then
      vim.notify("Nenhum teste encontrado na posição do cursor", vim.log.levels.INFO)
      return
    end

    if #tests == 1 then
      execute_runnable(tests[1])
      return
    end

    vim.ui.select(tests, {
      prompt = "Rust: executar",
      format_item = function(runnable)
        return runnable.label
      end,
    }, function(choice)
      if choice then
        execute_runnable(choice)
      end
    end)
  end, 0)
end

--- Expande a macro sob o cursor em um buffer de rascunho.
local function expand_macro()
  local client = rust_analyzer_client()

  if not client then
    vim.notify("rust-analyzer não está ativo neste buffer", vim.log.levels.WARN)
    return
  end

  client:request("rust-analyzer/expandMacro", position_params(), function(err, expanded)
    if err then
      vim.notify("rust-analyzer: " .. tostring(err.message), vim.log.levels.ERROR)
      return
    end

    if not expanded or not expanded.expansion then
      vim.notify("Nada para expandir na posição do cursor", vim.log.levels.INFO)
      return
    end

    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(expanded.expansion, "\n"))
    vim.bo[buf].filetype = "rust"
    vim.api.nvim_set_current_buf(buf)
  end, 0)
end

function M.setup()
  local group = vim.api.nvim_create_augroup("rust_keymaps", { clear = true })

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    pattern = "rust",
    callback = function(args)
      local opts = { buffer = args.buf, silent = true }

      vim.keymap.set("n", "<leader>rt", run_test,
        vim.tbl_extend("force", opts, { desc = "Rust: run test" }))

      vim.keymap.set("n", "<leader>rm", expand_macro,
        vim.tbl_extend("force", opts, { desc = "Rust: expand macro" }))
    end,
  })
end

return M
