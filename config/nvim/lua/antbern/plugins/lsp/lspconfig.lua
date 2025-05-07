return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {},
	config = function()
		local blink_cmp = require("blink.cmp")

		local keymap = vim.keymap -- for conciseness

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			-- set keybinds
			opts.desc = "Show LSP references"
			keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "Show LSP definitions"
			keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, opts) -- jump to next diagnostic in buffer

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

			-- if we are running neovim 0.10 or later, enable inlay hints.
			if vim.fn.has("nvim-0.10") == 1 then
				vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
			else
				error("Please upgrade to neovim 0.10 or later")
			end
		end

		-- auto format on save if LSP supports
		vim.api.nvim_create_autocmd('LspAttach', {
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if not client then return end

				if client:supports_method('textDocument/formatting') then
					-- Format the current buffer on save
					vim.api.nvim_create_autocmd('BufWritePre', {
						buffer = args.buf,
						callback = function()
							vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
						end
					})
				end
			end
		})

		-- used to enable autocompletion (assign to every lsp server config)
		-- local capabilities = cmp_nvim_lsp.default_capabilities()
		local capabilities = blink_cmp.get_lsp_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = ' ',
					[vim.diagnostic.severity.WARN] = ' ',
					[vim.diagnostic.severity.HINT] = '󰠠 ',
					[vim.diagnostic.severity.INFO] = ' ',
				},
				texthl = {
					[vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
					[vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
					[vim.diagnostic.severity.HINT] = 'DiagnosticSignHint',
					[vim.diagnostic.severity.INFO] = 'DiagnosticSignInfo',
				},
				numhl = {
					[vim.diagnostic.severity.ERROR] = '',
					[vim.diagnostic.severity.WARN] = '',
					[vim.diagnostic.severity.HINT] = '',
					[vim.diagnostic.severity.INFO] = '',
				},
			},
		})

		-- try to load local `.lspconfig.json` file
		local function json_file(path)
			local file = io.open(path, "rb")
			if not file then
				return {}
			end
			local content = file:read("*a")
			-- print(content)
			file:close()
			return vim.json.decode(content) or {}
		end
		local local_config = json_file(".lspconfig.json")
		-- # print table
		-- print(vim.inspect(local_config))

		-- configure html language server
		vim.lsp.enable("html")
		vim.lsp.config("html", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- Python
		vim.lsp.enable("pyright")
		vim.lsp.config("pyright", {
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure rust language server
		local rust_analyzer_config = local_config["rust_analyzer"] or {}
		rust_analyzer_config["diagnostics"] = { enable = false }
		vim.lsp.enable("rust_analyzer")
		vim.lsp.config('rust_analyzer', {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				['rust-analyzer'] = rust_analyzer_config
			},
		})

		-- configure lua server (with special settings)
		vim.lsp.enable("lua_ls")
		vim.lsp.config('lua_ls', {
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})
	end

}
