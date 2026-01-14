local keymap = vim.keymap

-- nvim-tree
keymap.set("n", "<c-q>", ":NvimTreeOpen<cr>", { silent = true })
keymap.set("n", "<c-c>", ":NvimTreeClose<cr>", { silent = true })

-- telescope
keymap.set("n", "tg", '<cmd>lua require("telescope.builtin").live_grep()<cr>')
keymap.set("n", "tf", '<cmd>lua require("telescope.builtin").find_files()<cr>')

-- lazygit
keymap.set("n", "<leader>g", ":LazyGit<cr>")

-- flash
keymap.set("n", "<leader>s", ":lua require('flash').jump()<cr>")

-- color scheme (Acme editor style)
vim.cmd("colorscheme acme")

-- copilot
vim.g.copilot_filetypes = { markdown = true, gitcommit = true, yaml = true }
keymap.set("i", "<Tab>", function()
	if require("copilot.suggestion").is_visible() then
		require("copilot.suggestion").accept()
	else
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
	end
end, {
	silent = true,
})

-- vim-delve
keymap.set("n", "<leader>dab", ":DlvAddBreakpoint<cr>")
keymap.set("n", "<leader>drb", ":DlvRemoveBreakpoint<cr>")
keymap.set("n", "<leader>dca", ":DlvClearAll<cr>")
keymap.set("n", "<leader>dt", ":DlvTest<cr>")
keymap.set("n", "<leader>dd", ":DlvDebug<cr>")

-- nvim-lspconfig
keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
keymap.set("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>")
keymap.set("n", "<leader><space>", "<cmd>lua vim.diagnostic.goto_next()<cr>")
