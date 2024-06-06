return {
	'saecki/crates.nvim',
	tag = 'stable',
	config = function()
		require('crates').setup()

		local crates = require("crates")
		local opts = { silent = true }

		opts.desc = "Show versions popup (Crates)"
		vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, opts)
		opts.desc = "Show features popup (Crates)"
		vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts)
		opts.desc = "Show dependencies popup (Crates)"
		vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, opts)

		opts.desc = "Show popup (Crates)"
		vim.keymap.set("n", "<leader>cd", crates.show_popup, opts)
	end,
}
