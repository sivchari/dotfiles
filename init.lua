local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { 'lambdalisue/fern.vim' },
  { 'kdheepak/lazygit.nvim' },
  {
    'phaazon/hop.nvim',
    config = function()
      require('hop').setup({})
    end
  },
  { 'nvim-lua/plenary.nvim' },
  { 'nvim-telescope/telescope.nvim' },
  {
    'crispgm/nvim-tabline',
    config = function()
      require('tabline').setup({
        show_index = true,
        show_modify = true,
        modify_indicator = '[+]',
      })
    end
  },
  { 'rust-lang/rust.vim' },
  { 'neovim/nvim-lspconfig' },
  { 'neoclide/coc.nvim' },
  {
    'rust-lang/rust.vim',
    ft = "rs",
  },
  { 'tpope/vim-commentary' },
})
require('config')
require('plugins_config')

