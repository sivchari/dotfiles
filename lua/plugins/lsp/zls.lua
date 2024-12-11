return {
	on_attach = function(client, _)
		if client.server_capabilities.inlayHintProvider then
			vim.lsp.inlay_hint.enable(true)
		end
	end,
}
