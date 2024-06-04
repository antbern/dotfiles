return {
	'akinsho/bufferline.nvim',
	-- version = "*",
	dependencies = 'nvim-tree/nvim-web-devicons',
	config = function()
		vim.opt.termguicolors = true
		vim.opt.mousemoveevent = true

		require("bufferline").setup({
			options = {
				mode = 'buffers',
				offsets = {
					{
						filetype = 'NvimTree',
						--text = "File Explorer",
						highlight = "Directory",
						separator = true,
						text = function()
							return vim.fn.getcwd()
						end,
					}
				},
				diagnostics = 'nvim_lsp',
				hover = {
					enabled = true,
					delay = 200,
					reveal = { 'close' }
				},
				show_buffer_icons = true,
				show_duplicate_prefix = true,
				separator_styles = "thick",
			},
			highlights = {
				buffer_selected = {
					italic = false
				},
				indicator_selected = {
					fg = { attribute = 'fg', highlight = 'Function' },
					italic = false
				}
			}
		})

		vim.keymap.set("n", "<leader>q", "<cmd>:BufferLineCyclePrev<CR>")
		vim.keymap.set("n", "<leader>e", "<cmd>:BufferLineCycleNext<CR>")
		vim.keymap.set("n", "<leader>x", "<cmd>:BufferLinePickClose<CR>")


		vim.keymap.set("n", "<leader>1", "<cmd>:BufferLineGoToBuffer 1<CR>")
		vim.keymap.set("n", "<leader>2", "<cmd>:BufferLineGoToBuffer 2<CR>")
		vim.keymap.set("n", "<leader>3", "<cmd>:BufferLineGoToBuffer 3<CR>")
		vim.keymap.set("n", "<leader>4", "<cmd>:BufferLineGoToBuffer 4<CR>")
		vim.keymap.set("n", "<leader>5", "<cmd>:BufferLineGoToBuffer 5<CR>")
		vim.keymap.set("n", "<leader>6", "<cmd>:BufferLineGoToBuffer 6<cr>")

		--vim.keymap.set("n", "<leader>x", "<cmd>:q<cr>")
	end
}
