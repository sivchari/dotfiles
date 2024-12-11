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
	{ "github/copilot.vim" },
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
	{
		"vim-test/vim-test",
		event = "VeryLazy",
	},
}
