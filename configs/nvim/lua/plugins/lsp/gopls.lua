return {
    cmd = { "golance" },
	filetypes = { "go", "gotmpl", "gomod", "gowork" },
	on_attach = function(client, _)
		if client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint.enable(true)
		end
	end,
	settings = {
		gopls = {
			hints = {
				assignVariableTypes = true,
				compositeLiteralFields = true,
				compositeLiteralTypes = true,
				constantValues = true,
				functionTypeParameters = true,
				parameterNames = true,
				rangeVariableTypes = true,
			},
            buildFlags = {
                "-tags=e2e",
            },
		},
	},
}
