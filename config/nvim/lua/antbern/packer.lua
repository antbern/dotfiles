-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		-- or                            , branch = '0.1.x',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}
	--  use({ 'rose-pine/neovim', as = 'rose-pine', config = function()
	--	  vim.cmd('colorscheme rose-pine')
	--  end})

	use('Mofiqul/dracula.nvim')

	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
	use('nvim-treesitter/playground')

	use('theprimeagen/harpoon')
	use('mbbill/undotree')
	use('tpope/vim-fugitive')

	use {
		'VonHeikemen/lsp-zero.nvim',
		branch = 'v2.x',
		requires = {
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
		}
	}

	-- might not be good, replace with toggle-term?
	use('voldikss/vim-floaterm')

	use {
		'lewis6991/gitsigns.nvim',
		tag = 'release',
	}

	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'nvim-tree/nvim-web-devicons', opt = true }
	}

	use {
		'akinsho/bufferline.nvim',
		tag = "*",
		requires = 'nvim-tree/nvim-web-devicons'
	}

	-- For indentation guidelines
	use "lukas-reineke/indent-blankline.nvim"
	--use { "lukas-reineke/indent-blankline.nvim",
	--	config = {
		--		show_current_context = true,
		--		show_current_context_start = true,
		--	}
		--}
	
	use('christoomey/vim-tmux-navigator')
end)
