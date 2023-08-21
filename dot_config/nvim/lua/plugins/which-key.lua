local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = {
    "lewis6991/hover.nvim",
  },
}

function M.config()
  local wk = require("which-key")

  wk.setup({})

  wk.register({
    K = {
      function()
        require("hover").hover()
      end,
      "More information",
    },
    ["KS"] = {
      function()
        require("hover").hover_select()
      end,
      "More information (select)",
    },
  }, { mode = "n" })

  -- Window navigation
  local nvim_tmux_nav = require("nvim-tmux-navigation")
  wk.register({
    ["<C-h>"] = { nvim_tmux_nav.NvimTmuxNavigateLeft, "Window - Navigate left" },
    ["<C-j>"] = { nvim_tmux_nav.NvimTmuxNavigateDown, "Window - Navigate down" },
    ["<C-k>"] = { nvim_tmux_nav.NvimTmuxNavigateUp, "Window - Navigate up" },
    ["<C-l>"] = { nvim_tmux_nav.NvimTmuxNavigateRight, "Window - Navigate right" },
  })

  -- With <leader>
  wk.register({
    c = {
      name = "Code",
      ["ä"] = { vim.diagnostic.goto_prev, "Diagnostics - previous" },
      ["ö"] = { vim.diagnostic.goto_next, "Diagnostics - next" },
      f = {
        function()
          vim.lsp.buf.format({ async = false })
        end,
        "Format code",
      },
      r = {
        function()
          vim.lsp.buf.rename()
        end,
        "Rename definition",
      },
      q = { "<cmd>Telescope quickfix<cr>", "Quickfix" },
      d = { "<cmd>Telescope diagnostics<cr>", "Diagnostics" },
      t = { "<cmd>TroubleToggle document_diagnostics<cr>", "Trouble list" },
      s = { "<cmd>SymbolsOutline<cr>", "Symbol list" },
      a = {
        function()
          vim.lsp.buf.code_action()
        end,
        "Code action",
      },
    },
    f = {
      name = "File",
      f = { "<cmd>Telescope find_files<cr>", "Find file" },
      g = { "<cmd>Telescope live_grep<cr>", "File grep" },
      l = { "<cmd>Telescope file_browser<cr>", "File list" },
      b = { "<cmd>Telescope buffers<cr>", "File buffer" },
      r = { "<cmd>Telescope recent_files pick<cr>", "Recent files" },
    },
    g = {
      name = "Git",
      h = { "<cmd>Gitsigns toggle_linehl<cr>", "Toggle line highlight" },
      r = { "<cmd>Telescope repo list<cr>", "Repository list" },
      s = { "<cmd>Telescope git_status<cr>", "Status" },
      --b = { "<cmd>Telescope git_branches<cr>", "Branches" },
      b = { "<cmd>Gitsigns toggle_current_line_blame<cr>", "Toggle line blame" },
      B = {
        function()
          require("gitsigns").blame_line({ full = true })
        end,
        "Full blame for line",
      },
      c = { "<cmd>Telescope git_commits<cr>", "Commits" },
    },
    n = {
      name = "Notes",
      t = { "<cmd>TodoTrouble<cr>", "Todo list" },
    },
    T = { "<cmd>Telescope<cr>", "Telescope" },
  }, { mode = "nv", prefix = "<leader>" })
end

return M
