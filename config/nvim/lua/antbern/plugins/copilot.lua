return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		require("copilot").setup({
			-- suggestion = { enabled = true, auto_trigger = true },
			suggestion = { enabled = false },
			panel = { enabled = false },
		})

		vim.api.nvim_set_keymap("i", "<C-Space>", "<Plug>(copilot_suggest)", {})
		vim.api.nvim_set_keymap("i", "<C-Enter>", "<Plug>(copilot_accept)", {})
		vim.api.nvim_set_keymap("i", "<C-n>", "<Plug>(copilot_next)", {})
		vim.api.nvim_set_keymap("i", "<C-p>", "<Plug>(copilot_prev)", {})

		-- vim.api.nvim_set_keymap("i", "<C-Space>", "<Plug>(copilot_suggest)", {})
		-- vim.api.nvim_set_keymap("i", "<C-Enter>", require("copilot.suggestion").accept_line, {})
		-- vim.api.nvim_set_keymap("i", "<C-n>", require("copilot.suggestion").next, {})
		-- vim.api.nvim_set_keymap("i", "<C-p>", require("copilot.suggestion").prev, {})
	end,

}
