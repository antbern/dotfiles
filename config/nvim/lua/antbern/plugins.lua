-- heavily inspired by https://github.com/jdhao/nvim-config/blob/7ff11a9760fcb7cc122de066528b07b1028f7bce/lua/plugins.lua


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    }
end
vim.opt.rtp:prepend(lazypath)



require("lazy").setup {
    -- Language Server Setup
    {
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
            require("antbern.config.lsp")
        end,
	},
    {
        'hrsh7th/cmp-nvim-lsp-signature-help'
    },

    {
        "nvim-treesitter/nvim-treesitter",
        event = "VeryLazy",
        build = ":TSUpdate",
        config = function()
          require("antbern.config.treesitter")
        end,
    },

    -- Tmux integration
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },

    -- Fuzzy file finder
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require("antbern.config.telescope")
        end,
    },

    -- File quicklist
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("antbern.config.harpoon")
        end,
    },

    -- Git integration
    {
        'tpope/vim-fugitive',
        config = function()
            require("antbern.config.fugitive")
        end,
    },
    {
		'lewis6991/gitsigns.nvim', tag = 'release',
        config = function()
            require("antbern.config.gitsigns")
        end,

	},

    -- Buffer line styling
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        config = function()
            require("antbern.config.bufferline")
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("antbern.config.lualine")
        end,
    },

	-- For indentation guidelines
    { 
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {}
    },

    -- Better undo support
    {
        'mbbill/undotree',
        config = function()
            require("antbern.config.undotree")
        end,
    },

    -- Color scheme
    {
        "catppuccin/nvim", name = "catppuccin",
    },

    -- For opening a terminal
    -- TODO: might not be good, replace with toggle-term?
    {
        'voldikss/vim-floaterm',
        config = function()
            require("antbern.config.floaterm")
        end,
    },

    -- Rust support and integration
    {
        "mrcjkb/rustaceanvim",
        version = "^4",
        dependencies = {
          "nvim-lua/plenary.nvim",
          "mfussenegger/nvim-dap",
          {
            "lvimuser/lsp-inlayhints.nvim",
            opts = {}
          },
        },
        ft = { "rust" },
        config = function()
          vim.g.rustaceanvim = {
            inlay_hints = {
              highlight = "NonText",
              auto = false,
            },
            tools = {
			  autoSetHints = true,
			  inlay_hints = {
	            show_parameter_hints = true,
                parameter_hints_prefix = "in: ", -- "<- "
                other_hints_prefix = "out: "     -- "=> "  
			  },
              hover_actions = {
                auto_focus = true,
              },
            },
            server = {
              on_attach = function(client, bufnr)
                require("lsp-inlayhints").on_attach(client, bufnr)
              end
            }
          }
        end
    },
    {
        'saecki/crates.nvim',
        tag = 'stable',
        config = function()
            require('crates').setup()
        end,
    },
}
      
