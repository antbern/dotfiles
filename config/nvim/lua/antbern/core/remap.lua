vim.g.mapleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- exit insert mode with jk (lets see if this is annoying or not...)
keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- using x to delete a characted will not store the character in a register
keymap.set("n", "x", '"_x')

-- increment and decrement numbers using + and -
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

-- control some windows
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make split windows equal width" })
keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close current split window" })

-- control tabs
keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })                     -- open new tab
keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })              -- close current tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })                     --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })                 --  go to previous tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Allow movement of selected / highlighted lines (with auto indenting!)
keymap.set("v", "J", ":m '>+1<CR>gv=gv'")
keymap.set("v", "K", ":m '<-2<CR>gv=gv'")

-- press J to append next line to this one but let cursor stay in place
keymap.set("n", "J", "mzJ`z")

-- half-page jumping but keep cursor in the middle
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- keep search terms in the middle
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- paste without replacing the copy buffer (can paste multiple times!)
keymap.set("x", "<leader>p", "\"_dP")

-- yank into system clipboard (buffer +)
keymap.set("n", "<leader>y", "\"+y")
keymap.set("v", "<leader>y", "\"+y")
keymap.set("n", "<leader>Y", "\"+Y")

-- delete into void register (not into yank register)
keymap.set("n", "<leader>d", "\"_d")
keymap.set("v", "<leader>d", "\"_d")


-- Make sure changes are saved when exiting vertical edit mode using C-c (it doesnt otherwise...)
--keymap.set("i", "<C-c>", "<Esc>")

-- Apparently Q is not a good place?
keymap.set("n", "Q", "<nop>")

-- maybe I'll start using tmux one day
keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

keymap.set("n", "<leader><leader>", function()
	vim.lsp.buf.format()
end)

-- Using quickfix list?
keymap.set("n", "<leader><C-k>", "<cmd>cnext<CR>zz")
keymap.set("n", "<leader><C-j>", "<cmd>cprev<CR>zz")
keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")


keymap.set("n", "<leader>w", "<cmd>:w<CR>")
keymap.set("n", "<leader>ww", "<cmd>:wa<CR>")


-- folding, see: https://www.jackfranklin.co.uk/blog/code-folding-in-vim-neovim/
local function close_all_folds()
	vim.api.nvim_exec2("%foldc!", { output = false })
end
local function open_all_folds()
	vim.api.nvim_exec2("%foldo!", { output = false })
end

vim.keymap.set("n", "<leader>zs", close_all_folds, { desc = "[s]hut all folds" })
vim.keymap.set("n", "<leader>zo", open_all_folds, { desc = "[o]pen all folds" })
