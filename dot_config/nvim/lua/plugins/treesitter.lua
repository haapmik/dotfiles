local M = {
  -- Tree-sitter general parser for syntax tree generation.
  -- Provides better syntax highlighting
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
}

function M.config()
  require("nvim-treesitter.configs").setup({
    ensure_installed = {
      "bash",
      "html",
      "javascript",
      "json",
      "lua",
      "php",
      "python",
      "typescript",
      "vim",
      "vimdoc",
    },
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  })
end

return M
