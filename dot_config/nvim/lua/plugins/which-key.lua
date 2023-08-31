local M = {
  "folke/which-key.nvim",
  event = "VeryLazy",
  dependencies = {
    "lewis6991/hover.nvim",
    --    "nvim-neotest/neotest",
    "nvim-tmux-navigation",
  },
}

function M.config()
  local wk = require("which-key")
  --  local neotest = require("neotest")
  local hover = require("hover")

  wk.setup({})

  wk.register({
    K = {
      function()
        hover.hover()
      end,
      "More information",
    },
    ["KS"] = {
      function()
        hover.hover_select()
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
    ["<C-w>m"] = { "<cmd>WindowsMaximize<cr>", "Window - Maximize" },
    ["<C-w>_"] = { "<cmd>WindowsMaximizeVertically<cr>", "Window - Maximize vertically" },
    ["<C-w>|"] = { "<cmd>WindowsMaximizeHorizontally<cr>", "Window - Maximize horizontally" },
    ["<C-w>="] = { "<cmd>WindowsEqualize<cr>", "Window - Equalize" },
  })

  -- With <leader>
  wk.register({
    b = {
      name = "Buffer",
      p = { "<cmd>BufferLinePick<cr>", "Bufferline - pick" },
      D = { "<cmd>BufferLinePickClose<cr>", "Bufferline - close" },
    },
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
    --    t = {
    --      name = "Test",
    --      r = {
    --        function()
    --          neotest.run.run()
    --        end,
    --        "Run nearest test",
    --      },
    --      R = {
    --        function()
    --          neotest.run.run(vim.fn.expand("%"))
    --        end,
    --        "Run the current file",
    --      },
    --      t = {
    --        function()
    --          neotest.run.stop()
    --        end,
    --        "Stop nearest test",
    --      },
    --      T = {
    --        function()
    --          neotest.run.stop(vim.fn.expand("%"))
    --        end,
    --        "Stop the current file",
    --      },
    --      O = {
    --        function()
    --          neotest.output_panel.toggle()
    --        end,
    --        "Toggle output panel",
    --      },
    --      o = {
    --        function()
    --          neotest.output({ short = true })
    --        end,
    --        "Open output display",
    --      },
    --      w = {
    --        function()
    --          neotest.watch.toggle()
    --        end,
    --        "Toggle watch to nearest tets",
    --      },
    --      W = {
    --        function()
    --          neotest.watch.toggle(vim.fn.expand("%"))
    --        end,
    --        "Toggle watch to the current file",
    --      },
    --      s = {
    --        function()
    --          neotest.summary.toggle()
    --        end,
    --        "Toggle summary",
    --      },
    --    },
    s = {
      name = "Session",
      s = { "<cmd>SessionSave<cr>", "Save session" },
      l = { "<cmd>SessionLoad<cr>", "Load session" },
      D = { "<cmd>SessionDelete<cr>", "Delete session" },
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
  }, { mode = "n", prefix = "<leader>" })
end

return M
