return {
	'nvim-telescope/telescope.nvim',
	branch = 'master',
	dependencies = {
		'nvim-lua/plenary.nvim',
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		'nvim-tree/nvim-web-devicons',
		"folke/trouble.nvim",
	},
	config = function()
		local telescope = require('telescope')
		local builtin = require('telescope.builtin')
		local actions = require('telescope.actions')

		local open_with_trouble = require("trouble.sources.telescope").open

		telescope.setup({
			defaults = {
				mappings = {
					i = {
						["<C-k>"] = actions.move_selection_previous, -- move to prev result
						["<C-j>"] = actions.move_selection_next, -- move to next result
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
						["<ESC>"] = actions.close,
						["<c-t>"] = open_with_trouble,
					},
					n = {
						["<c-t>"] = open_with_trouble,
					},
				}
			},
			pickers = {
				find_files = {
					hidden = true,
				}
			}
		})

		telescope.load_extension("fzf")
		-- telescope.load_extension("notify")
		-- set keymaps
		local keymap = vim.keymap -- for conciseness

		keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
		keymap.set("n", "<leader>fa", "<cmd>Telescope resume<cr>", { desc = "Resume last fuzzy find" })
		keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
		keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
		keymap.set("n", "<leader>fo", "<cmd>Telescope buffers<cr>", { desc = "Fuzzy find open buffers" })
		keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
		keymap.set("n", "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<cr>", { desc = "Fuzzy find diagnostics" })
		keymap.set("n", "<leader>ft", "<cmd>Telescope git_branches<cr>", { desc = "Fuzzy checout branches" })
		keymap.set('n', '<leader>fb', builtin.current_buffer_fuzzy_find, { desc = "Fuzzy find in current buffer" })
	end
}
