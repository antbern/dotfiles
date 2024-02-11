-- add plugins that does not require any special configuration here
return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {}
	},
	{ "tpope/vim-surround" },

	{
		'hrsh7th/cmp-nvim-lsp-signature-help'
	},

	-- TODO: should I keep these?
	-- File quicklist
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")

			-- REQUIRED
			harpoon:setup()
			-- REQUIRED


			vim.keymap.set("n", "<leader>a", function() harpoon:list():append() end)
			vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

			vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
			vim.keymap.set("n", "<C-n>", function() harpoon:list():select(2) end)
			vim.keymap.set("n", "<C-s>", function() harpoon:list():select(3) end)
			-- vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

			-- Toggle previous & next buffers stored within Harpoon list
			vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
			vim.keymap.set("n", "<C-S-N>", function() harpoon:list():next() end)
		end,


	},


	-- For opening a terminal
	-- TODO: might not be good, replace with toggle-term?
	{
		'voldikss/vim-floaterm',
		config = function()
			vim.keymap.set("n", "<leader>tt", "<cmd>FloatermToggle<CR>")
			vim.keymap.set("t", "<leader>tt", "<cmd>FloatermToggle<CR>")
			vim.keymap.set("t", "<C-h>", "<cmd>FloatermPrev<CR>")
			vim.keymap.set("t", "<C-l>", "<cmd>FloatermNext<CR>")
			vim.keymap.set("t", "<C-t>", "<cmd>FloatermNew<CR>")
		end,
	},

}
