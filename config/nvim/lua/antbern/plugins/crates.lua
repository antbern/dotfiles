return {
	'saecki/crates.nvim',
	tag = 'stable',
	config = function()
		local crates = require("crates")
		crates.setup({
			lsp = {
				enabled = true,
				on_attach = function(client, bufnr)
					-- the same on_attach function as for your other lsp's
					local opts = { silent = true, buffer = bufnr }

					opts.desc = "Show versions popup (Crates)"
					vim.keymap.set("n", "<leader>cv", crates.show_versions_popup, opts)
					opts.desc = "Show features popup (Crates)"
					vim.keymap.set("n", "<leader>cf", crates.show_features_popup, opts)
					opts.desc = "Show dependencies popup (Crates)"
					vim.keymap.set("n", "<leader>cd", crates.show_dependencies_popup, opts)

					opts.desc = "Show popup (Crates)"
					vim.keymap.set("n", "<leader>cd", crates.show_popup, opts)
				end,
				actions = true,
				completion = true,
				hover = true,
			}
		})
	end,
}
