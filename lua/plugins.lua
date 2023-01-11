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
  { 'kdheepak/lazygit.nvim' },
  {
    'phaazon/hop.nvim',
    config = function()
      require('hop').setup({})
    end,
  },
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-telescope/telescope.nvim' },
  { 'neoclide/coc.nvim' },
  { 'rust-lang/rust.vim', ft = "rs" },
  { 'tpope/vim-commentary' },
  { 'marko-cerovac/material.nvim' },
}
