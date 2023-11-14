return {
    {
        'nvim-tree/nvim-tree.lua',
        config = function()
            require('nvim-tree').setup({
                auto_reload_on_write = true,
                disable_netrw = false,
                sort_by = 'name',
                renderer = {
                    icons = {
                        show = {
                            file = false,
                            folder = false,
                            folder_arrow = false,
                            git = false,
                            modified = false,
                        },
                    },
                },
            })
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup({
                ensure_installed = { 'go', 'lua', 'rust', 'sql', 'yaml', 'typescript', 'tsx' },
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true
                },
            })
        end,
    },
    { 'kdheepak/lazygit.nvim' },
    {
        'folke/flash.nvim',
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "<leader>s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
            },
        },
    },
    { 
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
    },
    { 'neoclide/coc.nvim' },
    { 'tpope/vim-commentary' },
    { 'github/copilot.vim' },
    { 'projekt0n/github-nvim-theme' },
}
