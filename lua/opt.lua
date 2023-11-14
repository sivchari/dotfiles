vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.swapfile = false

vim.api.nvim_create_autocmd({'BufRead', 'BufEnter'}, {
    pattern = { '*.ts', '*.tsx' },
	command = ":setlocal tabstop=2 shiftwidth=2 expandtab"
})

