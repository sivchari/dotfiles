local M = {}

M.setup = function()
	local lspconfig = require("lspconfig")
	lspconfig.gopls.setup(require("plugins.lsp.gopls"))
	lspconfig.rust_analyzer.setup(require("plugins.lsp.rust"))
	lspconfig.zls.setup(require("plugins.lsp.zls"))
end

return M
