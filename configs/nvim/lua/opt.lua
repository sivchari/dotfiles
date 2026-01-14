vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false

-- Acme-style minimal UI
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.laststatus = 2
vim.opt.fillchars = { vert = "|", horiz = "-", eob = " " }
vim.opt.termguicolors = true

vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
	pattern = { "*.ts", "*.tsx" },
	command = ":setlocal tabstop=2 shiftwidth=2 expandtab",
})
