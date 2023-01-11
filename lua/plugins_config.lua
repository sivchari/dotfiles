-- nvim-tree
vim.keymap.set('n', '<c-q>', ':NvimTreeOpen<cr>', { silent = true })
vim.keymap.set('n', '<c-c>', ':NvimTreeClose<cr>', { silent = true })

-- telescope
vim.keymap.set('n', 'tg', '<cmd>lua require("telescope.builtin").live_grep()<cr>')
vim.keymap.set('n', 'tf', '<cmd>lua require("telescope.builtin").find_files()<cr>')

-- easymotion
vim.keymap.set('n', '<leader>c', ':HopChar1<cr>', { silent = true })
vim.keymap.set('n', '<leader>w', ':HopWord<cr>', { silent = true })
vim.keymap.set('n', '<leader>l', ':HopLine<cr>', { silent = true })

-- lazygit
vim.keymap.set('n', '<leader>g', ':LazyGit<cr>')

-- coc
vim.keymap.set('n', '[g', "<plug>(coc-diagnostic-prev)", { silent = true })
vim.keymap.set('n', ']g', "<plug>(coc-diagnostic-next)", { silent = true })
vim.keymap.set('n', 'gd', "<plug>(coc-definition)", { silent = true })
vim.keymap.set('n', 'gy', "<plug>(coc-type-definition)", { silent = true })
vim.keymap.set('n', 'gi', "<plug>(coc-implementation)", { silent = true })
vim.keymap.set('n', 'gr', "<plug>(coc-references)", { silent = true })
vim.keymap.set('n', 'K', '<cmd>lua _G.show_docs()<cr>', {silent = true })
function _G.show_docs()
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end

local completionopts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end
vim.keymap.set('i', '<TAB>', 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<tab>" : coc#refresh()', completionopts)
vim.keymap.set('i', '<S-TAB>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], completionopts)

-- coc-go
vim.api.nvim_create_autocmd({'BufWritePre'}, {
	pattern = { '*.go' },
	command = ":silent call CocAction('runCommand', 'editor.action.organizeImport')"
})
vim.keymap.set('n', '<leader>at', ':CocCommand go.tags.add json<cr>', { silent = true })
vim.keymap.set('n', '<leader>dt', ':CocCommand go.tags.clear<cr>', { silent = true })
vim.keymap.set('n', '<leader>tg', ':CocCommand go.test.generate.function<cr>', { silent = true })
vim.keymap.set('n', '<leader>tgf', ':CocCommand go.test.generate.file<cr>', { silent = true })
vim.keymap.set('n', '<leader>tge', ':CocCommand go.test.generate.exported<cr>', { silent = true })


