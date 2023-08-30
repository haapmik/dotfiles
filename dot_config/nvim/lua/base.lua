-- Misc
vim.opt.cmdheight = 2
vim.opt.cursorline = true
vim.opt.lazyredraw = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.scrolloff = 5
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.updatetime = 300
vim.opt.wildignore:append({ "*/node_modules/*" })
vim.opt.autochdir = true

-- Matchpair
-- fix slowdown issues with large files
--vim.g.loaded_matchparen = 1 -- Disable built-in matchparen
vim.g.matchparen_timeout = 20 -- ms
vim.g.matchparen_insert_timeout = 20 -- ms

-- Folding
vim.opt.foldcolumn = "auto"
vim.opt.foldlevel = 99 -- ufo provider needs a large value, can be decreased if required
vim.opt.foldlevelstart = 2
vim.opt.foldminlines = 2
vim.opt.foldmethod = "indent"
vim.opt.foldopen:append("insert")
vim.opt.foldenable = true
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- Blending
vim.opt.pumblend = 5
vim.opt.winblend = 5

-- Window
local winwidth = 10
vim.opt.winwidth = winwidth
vim.opt.winminwidth = winwidth
vim.opt.equalalways = false

-- Line wrapping
vim.opt.linebreak = true -- line break between words
vim.opt.showbreak = "+++"

-- Indentation
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4

-- Setup directories
local cache_dir = vim.env.HOME .. "/.cache/nvim"
vim.opt.swapfile = false
vim.opt.directory = cache_dir .. "/swap/"
vim.opt.undofile = true
vim.opt.undodir = cache_dir .. "/undo/"
vim.opt.backupdir = cache_dir .. "/backup/"
vim.opt.viewdir = cache_dir .. "/view/"
vim.opt.spellfile = cache_dir .. "/spell/en.utf-8.add"
