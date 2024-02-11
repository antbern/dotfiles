return {
	'VonHeikemen/lsp-zero.nvim',
	branch = 'v2.x', -- TODO: update to v3.x
	dependencies = {
		-- LSP Support
		{ 'neovim/nvim-lspconfig' }, -- Required
		{
			-- Optional
			'williamboman/mason.nvim',
			run = function()
				pcall(vim.cmd, 'MasonUpdate')
			end,
		},
		{ 'williamboman/mason-lspconfig.nvim' }, -- Optional

		-- Autocompletion
		{ 'hrsh7th/nvim-cmp' }, -- Required
		{ 'hrsh7th/cmp-nvim-lsp' }, -- Required
		{ 'L3MON4D3/LuaSnip' }, -- Required
	},

	config = function()
		local lsp = require("lsp-zero")

		lsp.preset("recommended")

		lsp.ensure_installed({
			'lua_ls',
			'rust_analyzer',
			'pylsp',
		})

		require('lspconfig').pylsp.setup({
			settings = {
				pylsp = {
					plugins = {
						black       = { enabled = true },
						autopep8    = { enabled = false },
						yapf        = { enabled = false },
						flake8      = { enabled = true },
						pycodestyle = { enabled = false },
						mccabe      = { enabled = false },
						pyflakes    = { enabled = false },
						isort       = { enabled = true },
						pylsp_mypy  = { enabled = true, report_progress = true }
					}
				}
			},
			on_attach = function(client, bufnr)
				lsp.async_autoformat(client, bufnr)
			end,
		})


		lsp.extend_cmp()

		local cmp = require('cmp')
		local cmp_select = { behavior = cmp.SelectBehavior.Select }
		local cmp_mappings = lsp.defaults.cmp_mappings({
			['<C-k>'] = cmp.mapping.select_prev_item(cmp_select),
			['<C-j>'] = cmp.mapping.select_next_item(cmp_select),
			['<Tab>'] = cmp.mapping.confirm({ select = true }),
			['<C-l>'] = cmp.mapping.confirm({ select = true }),
			['<C-Space>'] = cmp.mapping.complete(),
		})

		lsp.setup_nvim_cmp({
			mapping = cmp_mappings,
			sources = {
				{ name = "nvim_lsp_signature_help" }
			}
		})


		lsp.set_preferences({
			sign_icons = {}
		})

		lsp.set_sign_icons({
			error = '✘',
			warn = '▲',
			hint = '⚑',
			info = '»'
		})

		lsp.setup_nvim_cmp({
			mapping = cmp_mappings,
			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},
		})

		local signs = {
			ERROR = '',
			WARN = '',
			HINT = '󰌵',
			INFO = '',
		}

		-- Update the diagnostics each time you type!
		vim.diagnostic.config({
			update_in_insert = true,
			--	virtual_text = {
			--		prefix = function(diagnostic)
			--			return signs[vim.diagnostic.severity[diagnostic.severity]]
			--		end,
			--	},
		})

		lsp.on_attach(function(client, bufnr)
			local opts = { buffer = bufnr, remap = false }

			vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
			vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
			vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
			vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
			vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
			vim.keymap.set("n", "d]", function() vim.diagnostic.goto_prev() end, opts)
			vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
			vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
			vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
			vim.keymap.set("n", "<leader>vh", function() vim.lsp.buf.signature_help() end, opts)
		end)

		lsp.setup()
	end
}