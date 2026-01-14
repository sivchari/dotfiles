vim.filetype.add({
	extension = {
		graphqls = "graphql",
		tmpl = "gotmpl",
		gotmpl = "gotmpl",
	},
	filename = {
		["go.mod"] = "gomod",
		["go.work"] = "gowork",
	},
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
vim.g.mapleader = ","
require("lazy").setup("plugin")
require("opt")
require("keymap")
require("plugins.keymap")
