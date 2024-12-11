return {

	on_attach = function(client, _)
		if client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint.enable(true)
		end
	end,
	settings = {
		["rust-analyzer"] = {
			checkOnSave = {
				command = "clippy",
			},
			cargo = {
				loadOutDirsFromCheck = true,
			},
			inlayHints = {
				bindingModeHints = {
					enable = true,
				},
				chainingHints = {
					enable = true,
				},
				closingBraceHints = {
					enable = true,
				},
				closureCaptureHints = {
					enable = true,
				},
				genericParameterHints = {
					const = {
						enable = true,
					},
					lifetime = {
						enable = true,
					},
					type = {
						enable = true,
					},
				},
			},
		},
	},
}
