local M = {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    -- Test adapters
    "nvim-neotest/neotest-jest",
  },
}

function M.config()
  require("neotest").setup({
    adapters = {
      require('neotest-jest')({
        jestCommand = "npm test --",
        jestConfigFile = ".jestrc.ts",
        env = { CI = true, NODE_ENV = "test", },
        cwd = function(path)
          return vim.fn.getcwd()
        end,
      }),
    }
  })
end

return M
