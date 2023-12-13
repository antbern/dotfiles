local builtin = require('telescope.builtin')
-- TODO: add live grep builtin.live_grep()
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
	-- Note: requires `ripgrep` to be installed
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
