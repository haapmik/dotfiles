local util = require("lspconfig").util

local M = {
  root_dir = util.root_pattern("rome.json"),
}

return M
