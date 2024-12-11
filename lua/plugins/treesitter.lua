local M = {}

M.setup = function()
	require("nvim-treesitter.configs").setup({
		ensure_installed = { "go", "lua", "rust", "sql", "yaml", "typescript", "tsx" },
		highlight = {
			enable = true,
		},
		indent = {
			enable = true,
		},
	})
end

return M
