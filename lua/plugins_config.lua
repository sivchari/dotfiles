local keymap = vim.keymap

-- nvim-tree
keymap.set("n", "<c-q>", ":NvimTreeOpen<cr>", { silent = true })
keymap.set("n", "<c-c>", ":NvimTreeClose<cr>", { silent = true })

-- telescope
keymap.set("n", "tg", '<cmd>lua require("telescope.builtin").live_grep()<cr>')
keymap.set("n", "tf", '<cmd>lua require("telescope.builtin").find_files()<cr>')

-- easymotion
keymap.set("n", "<leader>c", ":HopChar1<cr>", { silent = true })
keymap.set("n", "<leader>w", ":HopWord<cr>", { silent = true })
keymap.set("n", "<leader>l", ":HopLine<cr>", { silent = true })

-- lazygit
keymap.set("n", "<leader>g", ":LazyGit<cr>")

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
