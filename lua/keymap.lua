local keymap = vim.keymap

keymap.set('n', '<space><space>', '<c-o>', { silent = true })
keymap.set('i', '<delete>', '<esc>', { silent = true })
keymap.set('n', '<delete>', 's', { silent = true })
