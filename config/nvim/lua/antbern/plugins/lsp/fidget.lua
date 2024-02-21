return {
	"j-hui/fidget.nvim",
	opts = {
		-- options
		progress = {
			-- Options related to Neovim's built-in LSP client
			lsp = {
				-- See: https://github.com/j-hui/fidget.nvim/issues/167 for explanation
				progress_ringbuf_size = 2048, -- Configure the nvim's LSP progress ring buffer size to make rust_analyzer updates work correctly
			},
		},
	},
}
