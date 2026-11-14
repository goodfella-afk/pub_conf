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
