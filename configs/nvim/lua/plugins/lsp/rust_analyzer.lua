return {
	on_attach = function(client, _)
		if client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint.enable(true)
		end
		if client.server_capabilities.documentFormattingProvider then
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = vim.api.nvim_create_augroup("rust_format", { clear = true }),
				buffer = 0,
				callback = function()
					vim.lsp.buf.format({ async = true })
				end,
			})
		end
	end,
	settings = {
		["rust-analyzer"] = {
			checkOnSave = true,
			cargo = {
				loadOutDirsFromCheck = true,
			},
			rustc = {
				source = "discover",
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
