-- Configuração do ecossistema Rust (rust-analyzer, rustfmt e clippy).
--
-- O rustup instala os binários (cargo, rustfmt, clippy) em ~/.cargo/bin, que
-- normalmente não faz parte do PATH do Neovim quando ele é iniciado fora de
-- um shell interativo (por exemplo, via systemd ou por um gerenciador de janelas).
local cargo_bin = vim.fn.expand("~/.cargo/bin")

return {
  name = "rust",
  dir = vim.fn.stdpath("config") .. "/lua/eliaquinn/plugins/rust",
  init = function()
    if vim.fn.isdirectory(cargo_bin) == 0 then
      return
    end

    if vim.env.PATH:find(cargo_bin, 1, true) then
      return
    end

    -- Adicionado ao final do PATH de propósito: os binários do Mason
    -- (rust-analyzer e taplo) precisam continuar com prioridade, pois o
    -- proxy `rust-analyzer` do rustup só funciona com o componente
    -- `rust-analyzer` instalado.
    vim.env.PATH = vim.env.PATH .. ":" .. cargo_bin
  end,
  config = function()
    require("eliaquinn.plugins.rust.keymaps").setup()
  end,
}
