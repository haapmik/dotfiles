local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local function autocmd_create_dir()
  -- Auto create dir when saving a file, in case some intermediate directory does not exist
  -- based on https://github.com/NickP-real/.dotfile/tree/main
  autocmd({ "BufWritePre" }, {
    group = augroup("auto_create_dir", { clear = true }),
    callback = function(event)
      if event.match:match("^%w%w+://") then
        return
      end
      local file = vim.loop.fs_realpath(event.match) or event.match
      vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
  })
end

autocmd_create_dir()
