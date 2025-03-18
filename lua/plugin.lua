return {
	{
		"nvim-tree/nvim-tree.lua",
		event = "VimEnter",
		config = function()
			require("plugins.tree").setup()
		end,
	},
	{
		"kdheepak/lazygit.nvim",
		event = "VeryLazy",
	},
	{ "mattn/vim-goimports" },
	{
		"nacro90/numb.nvim",
		config = function()
			require("plugins.numb").setup()
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
	},
	{
		"nvim-telescope/telescope.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"tpope/vim-commentary",
		event = "VeryLazy",
	},
	{
		"zbirenbaum/copilot.lua",
		config = function()
			require("copilot").setup({
				suggestion = {
					auto_trigger = true,
					keymap = {
						accept = "<tab>",
					},
				},
			})
		end,
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		lazy = false,
		version = false,
		opts = {
			provider = "copilot",
			auto_suggestions_provider = "copilot",
			behaviour = {
				auto_suggestions = true,
				auto_set_highlight_group = true,
				auto_set_keymaps = true,
				auto_apply_diff_after_generation = true,
				support_paste_from_clipboard = true,
			},
			windows = {
				position = "right",
				width = 30,
				sidebar_header = {
					align = "center",
					rounded = false,
				},
				ask = {
					floating = true,
					start_insert = true,
					border = "rounded",
				},
			},
		},
		build = "make",
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {
			file_types = { "markdown", "Avante" },
		},
		ft = { "markdown", "Avante" },
	},
	{ "projekt0n/github-nvim-theme" },
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-vsnip" },
			{ "hrsh7th/cmp-cmdline" },
			{ "hrsh7th/vim-vsnip" },
			{ "onsails/lspkind.nvim" },
		},
		config = function()
			require("plugins.cmp").setup()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VimEnter",
		build = ":TSUpdate",
		config = function()
			require("plugins.treesitter").setup()
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("plugins.lsp.config").setup()
		end,
	},
	{
		"sebdah/vim-delve",
		event = "VeryLazy",
	},
}
