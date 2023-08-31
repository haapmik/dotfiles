local M = {
  "olimorris/persisted.nvim",
  event = "BufReadPre",
}

function M.config()
  local persisted = require("persisted")

  vim.opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

  persisted.setup({
    save_dir = vim.fn.expand(vim.fn.stdpath("data") .. "/sessions/"),
    use_git_branch = true,
    autosave = true,
    autoload = true,
    on_autoload_no_session = function()
      vim.notify("No existing session to load!")
    end,
    follow_cwd = true,
    telescope = {
      reset_prompt_after_deletion = true,
    },
  })

  -- Add autocommands related to session handling
  local session_group = vim.api.nvim_create_augroup("SessionGroup", {})
  vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = session_group,
    callback = function()
      pcall(vim.cmd, "SessionSave")
    end,
  })
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    group = session_group,
    callback = function()
      pcall(vim.cmd, "SessionLoad")
    end,
  })
end

return M
