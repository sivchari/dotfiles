local M = {}

M.setup = function()
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
			["<c-a>"] = cmp.mapping.select_prev_item(),
			["<c-s>"] = cmp.mapping.select_next_item(),
			["<c-q>"] = cmp.mapping.complete(),
			["<c-w>"] = cmp.mapping.abort(),
			["<c-d>"] = cmp.mapping.confirm({ select = true }),
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
			{ name = "cmdline" },
		},
	})
end

return M
