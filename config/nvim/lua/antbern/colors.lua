function ColorMyPencils(color)
	color = color or "catppuccin-mocha"
	vim.cmd.colorscheme(color)

	--vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	--vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })


	-- Setup the intentation here to make sure color scheme is set before

	--	vim.cmd [[highlight IndentBlanklineContextChar guifg=#aa5500 gui=nocombine]]
	--	vim.cmd [[highlight IndentBlanklineContextStart guifg="Label" guisp=#aa5500 gui=underline]]
	require("ibl").setup({
		-- for example, context is off by default, use this to turn it on
		--show_current_context = true,
		--show_current_context_start = true,
		--show_trailing_blankline_indent = false,
		--use_treesitter = true,
		--		char_highlight_list = { "Whitespace" },
	})
end

ColorMyPencils()
