return {
	'nvim-telescope/telescope.nvim',
	branch = '0.1.x',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		'nvim-tree/nvim-web-devicons',
	},
	config = function()
		local telescope = require('telescope')
		local builtin = require('telescope.builtin')
		local actions = require('telescope.actions')

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						["<ESC>"] = actions.close,
					}
				}
			}
		})

		telescope.load_extension("fzf")
		-- telescope.load_extension("notify")
		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })


		-- TODO: add live grep builtin.live_grep()
		-- vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
		-- vim.keymap.set('n', '<C-p>', builtin.git_files, {})
		-- vim.keymap.set('n', '<leader>ps', function()
		-- 	-- Note: requires `ripgrep` to be installed
		-- 	builtin.grep_string({ search = vim.fn.input("Grep > ") });
		-- end)

		-- vim.keymap.set('n', '<leader>lg', builtin.live_grep, {})
		-- vim.keymap.set('n', '<leader>of', builtin.oldfiles, {})
		vim.keymap.set('n', '<leader>fb', builtin.current_buffer_fuzzy_find, { desc = "Fuzzy find in current buffer" })
	end
}
