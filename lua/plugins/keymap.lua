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

-- color scheme
vim.cmd("colorscheme github_dark")

-- copilot
vim.g.copilot_filetypes = { markdown = true, gitcommit = true, yaml = true }

-- vim-delve
keymap.set("n", "<leader>dab", ":DlvAddBreakpoint<cr>")
keymap.set("n", "<leader>drb", ":DlvRemoveBreakpoint<cr>")
keymap.set("n", "<leader>dca", ":DlvClearAll<cr>")
keymap.set("n", "<leader>dt", ":DlvTest<cr>")
keymap.set("n", "<leader>dd", ":DlvDebug<cr>")

-- vim-test
keymap.set("n", "<leader>tt", ":TestNearest<cr>", { desc = "Run test" })
keymap.set("n", "<leader>T", ":TestFile<cr>", { desc = "Run test" })

-- nvim-lspconfig
keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
keymap.set("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
keymap.set("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<cr>")
keymap.set("n", "[g", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
keymap.set("n", "]g", "<cmd>lua vim.diagnostic.goto_next()<cr>")

-- zls
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.zig", "*.zon", "*.rs" },
	callback = function(ev)
		vim.lsp.buf.format()
	end,
})
