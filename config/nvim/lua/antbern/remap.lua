vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)


-- Allow movement of selected / highlighted lines (with auto indenting!)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv'")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv'")

-- press J to append next line to this one but let cursor stay in place
vim.keymap.set("n", "J", "mzJ`z")

-- half-page jumping but keep cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- keep search terms in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- paste without replacing the copy buffer (can paste multiple times!)
vim.keymap.set("x", "<leader>p", "\"_dP")

-- yank into system clipboard (buffer +)
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- delete into void register (not into yank register)
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")


-- Make sure changes are saved when exiting vertical edit mode using C-c (it doesnt otherwise...)
--vim.keymap.set("i", "<C-c>", "<Esc>")

-- Apparently Q is not a good place?
vim.keymap.set("n", "Q", "<nop>")

-- maybe I'll start using tmux one day
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<leader>", function ()
	vim.lsp.buf.format()	
end)

-- Using quickfix list?
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")


























--vim.keymap.set("b"





