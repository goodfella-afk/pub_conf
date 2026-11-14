vim.g.mapleader = " "

-- disable mouse support
vim.opt.mouse = ""

-- duh
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false

-- Indents
vim.opt.expandtab = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true

-- Search
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
-- hello matches hello and Hello / Hello matches only Hello
vim.opt.smartcase = true

-- UI
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.updatetime = 250
vim.opt.title = true
vim.opt.showcmd = true
vim.opt.laststatus = 0
vim.opt.completeopt = { "menuone", "popup", "noinsert" }

-- netrw
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3

-- File search
vim.opt.path:append("**")
vim.opt.wildmenu = true
vim.opt.wildoptions = "pum"

vim.opt.wildignore:append({
	"**/node_modules/**",
	"**/dist/**",
	"**/__pycache__/**",
})
