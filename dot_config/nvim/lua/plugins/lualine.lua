local M = {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
}

function M.config()
  require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = {
            {
                'filetype',
                icon_only = false,
                separator = { right = '' },
            },
            {
                'filename',
                file_status = true,
                path = 0,
                padding = { left = 0 },
                separator = { right = '' },
            },
        },
        lualine_x = {
            {
                'diagnostics',
                sources = { 'nvim_diagnostic' },
            },
            {
                'encoding',
                separator = { right = '' },
            },
            {
                'fileformat',
                padding = { left = 0, right = 1 },
            },
            {
                    require("lazy.status").updates,
                    cond = require("lazy.status").has_updates,
                    color = { fg = "#ff9e64" },
            },
        },
        lualine_y = {},
        lualine_z = {
            {
                'progress',
                padding = { left = 1, right = 1 },
                separator = { left = '' },
            },
            {
                'location',
                separator = { left = '' },
                padding = { left = 0 },
            },
        },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
            {
                'filename',
                file_status = true,
                path = 1,
                separator = { right = '' },
            },
            {
                'filetype',
                icon_only = true,
                padding = { left = 0 },
            },
        },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    extensions = {}
  })
end

return M
