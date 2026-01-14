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
	},
	{
		"tpope/vim-commentary",
		event = "VeryLazy",
	},
	{
		"zbirenbaum/copilot.lua",
		event = "VeryLazy",
		config = function()
			require("copilot").setup({
				suggestion = {
					auto_trigger = true,
					accept = false,
				},
			})
		end,
	},
	{
		"nvim-lua/plenary.nvim",
		event = "VeryLazy",
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
		event = "VeryLazy",
	},
	{
		"sebdah/vim-delve",
		event = "VeryLazy",
	},
	{
		"sivchari/claude-code",
		config = function()
			require("claude-code").setup()
		end,
		event = "VeryLazy",
	},
	{
		dir = "~/workspace/other/tinygo.vim",
		event = "VeryLazy",
	},
}
