local M = {}

M.setup = function()
	local lsps = {
		"gopls",
		"rust_analyzer",
		"ts_ls",
		"graphql",
		"buf_ls",
		"zls",
		"lua_ls",
		"pyright",
        "clangd",
	}
	for _, lsp in ipairs(lsps) do
		vim.lsp.config[lsp] = require("plugins.lsp." .. lsp)
		vim.lsp.enable(lsp)
	end
end

return M
