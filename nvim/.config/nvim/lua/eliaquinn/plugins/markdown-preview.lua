return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && npm install",
    keys = {
      { "gm", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" },
    },
    config = function()
      vim.g.mkdp_auto_close = true
      vim.g.mkdp_open_to_the_world = false -- Listen on localhost only
      vim.g.mkdp_open_ip = "127.0.0.1"     -- Use localhost
      vim.g.mkdp_browser = ""              -- Use default system browser
      vim.g.mkdp_echo_preview_url = true   -- Echo the URL in the command line
    end,
  },
}


-- return {
--   {
--     "iamcco/markdown-preview.nvim",
--     cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
--     ft = { "markdown" },
--     build = "cd app && yarn install",
--     init = function()
--       vim.g.mkdp_filetypes = { "markdown" }
--     end,
--     -- build = function() vim.fn["mkdp#util#install"]() end,
--     -- config = function()
--     --   vim.g.mkdp_auto_close = 1 -- Auto close preview when leaving markdown buffer
--     --   vim.g.mkdp_auto_start = 0 -- Do not auto start preview when opening a markdown file
--     -- end,
--   },
-- }
