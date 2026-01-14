local util = require("lspconfig.util")

return {
	cmd = { "buf", "beta", "lsp", "--timeout=0", "--log-format=text" },
	filetypes = { "proto" },
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		on_dir(util.root_pattern("buf.yaml", ".git")(fname))
	end,
}
