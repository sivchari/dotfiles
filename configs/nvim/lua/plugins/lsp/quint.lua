local util = require("lspconfig.util")

return {
	cmd = { "quint-language-server", "--stdio" },
	filetypes = { "quint" },
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		on_dir(util.root_pattern(".git")(fname) or vim.fs.dirname(fname))
	end,
}
