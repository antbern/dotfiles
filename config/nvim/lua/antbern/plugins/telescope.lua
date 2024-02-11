return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.5',
	-- or                              , branch = '0.1.x',
	dependencies = { 'nvim-lua/plenary.nvim' },

	config = function()
		local builtin = require('telescope.builtin')
		-- TODO: add live grep builtin.live_grep()
		vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
		vim.keymap.set('n', '<C-p>', builtin.git_files, {})
		vim.keymap.set('n', '<leader>ps', function()
			-- Note: requires `ripgrep` to be installed
			builtin.grep_string({ search = vim.fn.input("Grep > ") });
		end)

		vim.keymap.set('n', '<leader>lg', builtin.live_grep, {})
		vim.keymap.set('n', '<leader>of', builtin.oldfiles, {})
		vim.keymap.set('n', '<leader>fg', builtin.current_buffer_fuzzy_find, {})
	end
}
