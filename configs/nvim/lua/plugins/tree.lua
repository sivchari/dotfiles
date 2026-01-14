---@class TreeConfig
local M = {}

---Setup nvim-tree with modern configuration
---@return nil
function M.setup()
	local api = require("nvim-tree.api")

	---On attach function for nvim-tree
	---@param bufnr number Buffer number
	local function on_attach(bufnr)
		api.config.mappings.default_on_attach(bufnr)

		local ok, claude_ext = pcall(require, "claude-code.nvim_tree_extension")
		if ok then
			claude_ext.on_attach(bufnr)
		end
	end

	require("nvim-tree").setup({
		auto_reload_on_write = true,
		disable_netrw = false,
		sort = {
			sorter = "name",
		},
		view = {
			width = 30,
			side = "left",
		},
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
		filters = {
			dotfiles = false,
		},
		git = {
			enable = true,
		},
		on_attach = on_attach,
	})
end

return M
