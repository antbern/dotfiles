return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			debug = true,        -- Enable debugging
			-- See Configuration section for rest
		},
		-- See Commands section for default commands if you want to lazy load on them
		config = function()
			-- Registers copilot-chat source and enables it for copilot-chat filetype (so copilot chat window)
			require("CopilotChat.integrations.cmp").setup()

			-- You might also want to disable default <tab> complete mapping for copilot chat when doing this
			require('CopilotChat').setup({
				mappings = {
					complete = {
						insert = '',
					},
				},
				-- rest of your config
			})
		end,
		keys = {
			-- Show help actions with telescope
			{
				"<leader>cch",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.help_actions())
				end,
				desc = "CopilotChat - Help actions",
			},
			-- Show prompts actions with telescope
			{
				"<leader>ccp",
				function()
					local actions = require("CopilotChat.actions")
					require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
				end,
				desc = "CopilotChat - Prompt actions",
			},
			-- Toggle chat window
			{
				"<leader>cct",
				":CopilotChatToggle<CR>",
				desc = "CopilotChat - Toggle chat",
			},
		}

	},
}
