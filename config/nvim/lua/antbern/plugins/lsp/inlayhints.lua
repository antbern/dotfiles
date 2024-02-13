return {
	"lvimuser/lsp-inlayhints.nvim",
	lazy = true, -- this is loaded by lspconfig as a dependency
	config = function()
		-- first setup the pluging
		require("lsp-inlayhints").setup()
		-- for now this is diasabled in order to only attach it when we are running neovim 0.9 or lower

		-- the make it auto attach on "LspAttach" (from the docs)
		-- vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
		-- vim.api.nvim_create_autocmd("LspAttach", {
		-- 	group = "LspAttach_inlayhints",
		-- 	callback = function(args)
		-- 		if not (args.data and args.data.client_id) then
		-- 			return
		-- 		end
		--
		-- 		local bufnr = args.buf
		-- 		local client = vim.lsp.get_client_by_id(args.data.client_id)
		-- 		require("lsp-inlayhints").on_attach(client, bufnr)
		-- 	end,
		-- })
	end

}
