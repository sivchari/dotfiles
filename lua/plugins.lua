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
  { 'folke/flash.nvim',
    event = "VeryLazy",
    opts = {},
    keys = {
      {
        "<leader>s",
        mode = { "n", "x", "o" },
        function()
          -- default options: exact mode, multi window, all directions, with a backdrop
          require("flash").jump()
        end,
      },
      {
        "<leader>a",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
      },
    },
  },
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-telescope/telescope.nvim' },
  { 'neoclide/coc.nvim' },
  { 'rust-lang/rust.vim', ft = "rs" },
  { 'jjo/vim-cue', ft="cue" },
  { 'tpope/vim-commentary' },
  { 'jparise/vim-graphql' },
  { 'marko-cerovac/material.nvim' },
  { 'github/copilot.vim' },
}
