--==== general setting ====--
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
vim.o.laststatus = 0

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
--==== general setting end ====--

--==== remaps begin =====-- 
-- Yank to sys reg
vim.keymap.set('v', '<leader>y', '"+y')

-- Timestamp
vim.keymap.set('n', '<leader>t', 'i<C-R>=strftime("%d-%B-%Y-%H:%M")<CR><Esc>')

-- netrw project view
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- Timestamp
vim.keymap.set('n', '<leader>t', 'i<C-R>=strftime("%d-%B-%Y-%H:%M")<CR><Esc>')

-- J, K in visual mode move selection up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Moving lines upwards with J preserves cursor position
vim.keymap.set("n", "J", "mzJ`z")

-- Stay in the middle of the screen while searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Disable Q
vim.keymap.set("n", "Q", "<nop>")

-- Find and replace on word
vim.keymap.set(
	"n",
	"<leader>S",
	":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>"
)

-- chmod +x current file
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>")

-- Toggle 80-character color column
vim.keymap.set("n", "<leader>b", function()
	vim.opt.colorcolumn = vim.opt.colorcolumn:get()[1] == 80 and "" or "80"
end)

-- Toggle line wrapping
vim.keymap.set("n", "<leader>W", "<cmd>set wrap!<CR>")

-- Good old vanilla
vim.keymap.set("n", "<leader>/", ":find ", { desc = "Find file" })
vim.keymap.set("n", "<leader>q", "<cmd>bw<CR>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>+", "<cmd>enew<CR>", { desc = "New buffer" })
vim.keymap.set("n", "<leader>l", "<cmd>ls<CR>:b ", { desc = "List buffers" })
vim.keymap.set("n", "<leader>j", "<cmd>bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>k", "<cmd>bprev<CR>", { desc = "Previous buffer" })
--==== remaps END ====--


-- Bootstrap lazy.nvim (keep at the end)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

-- Plugins (keep at /.config/neovim/lua/plugins/plugname.lua)
require("lazy").setup("plugins")
