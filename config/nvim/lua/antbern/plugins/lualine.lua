return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		vim.opt.showmode = false

		local lualine = require("lualine")
		local lazy_status = require("lazy.status")

		local lsp_progress = require("lsp-progress")


		lualine.setup({
			options = { theme = "catppuccin" },
			sections = {
				lualine_c = {
					-- invoke `progress` here.
					lsp_progress.progress,
				},
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{ "encoding" },
					{ "fileformat" },
					{ "filetype" },
				},
			},
		})

		-- listen lsp-progress event and refresh lualine
		vim.api.nvim_create_augroup("lualine_augroup", { clear = true })
		vim.api.nvim_create_autocmd("User", {
			group = "lualine_augroup",
			pattern = "LspProgressStatusUpdated",
			callback = lualine.refresh,
		})
	end
}
