return {
	{
		"nvim-tree/nvim-tree.lua",
		event = "VimEnter",
		config = function()
			require("nvim-tree").setup({
				auto_reload_on_write = true,
				disable_netrw = false,
				sort_by = "name",
				renderer = {
					icons = {
						show = {
							file = false,
							folder = false,
							folder_arrow = false,
							git = false,
							modified = false,
						},
					},
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = "VimEnter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "go", "lua", "rust", "sql", "yaml", "typescript", "tsx" },
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
			})
		end,
	},
	{ "mattn/vim-goimports" },
	{
		"kdheepak/lazygit.nvim",
		event = "VeryLazy",
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"<leader>s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
			},
		},
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
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdlineEnter" },
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-vsnip" },
			{ "hrsh7th/vim-vsnip" },
			{ "onsails/lspkind.nvim" },
		},
		config = function()
			local lspkind = require("lspkind")
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "vsnip" },
					{ name = "buffer" },
					{ name = "path" },
				},
				mapping = cmp.mapping.preset.insert({
					["<C-a>"] = cmp.mapping.select_prev_item(),
					["<C-s>"] = cmp.mapping.select_next_item(),
					["<C-q>"] = cmp.mapping.complete(),
					["<C-w>"] = cmp.mapping.abort(),
					["<C-d>"] = cmp.mapping.confirm({ select = true }),
				}),
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol",
						maxwidth = 50,
						ellipsis_char = "...",
					}),
				},
			})
			cmp.setup.cmdline("/", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "buffer" },
				},
			})
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "path" },
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local on_attach = function(client, bufnr)
				local keymap = vim.keymap
				keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
				keymap.set("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
				keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
				keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
				keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
				keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>")
				keymap.set("n", "[g", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
				keymap.set("n", "]g", "<cmd>lua vim.diagnostic.goto_next()<cr>")
			end
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			require("mason-lspconfig").setup()
			require("mason-lspconfig").setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						on_attach = on_attach,
						capabilities = capabilities,
					})
				end,
			})
		end,
	},
	{ "neovim/nvim-lspconfig" },
}
