local null_ls = require("null-ls")
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local opts = {
	sources = {
		null_ls.builtins.formatting.gofumpt, -- Formatting source
		null_ls.builtins.formatting.goimports_reviser, -- Formatting source
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.jq.with({
			extra_args = { "--indent", "2" }, -- Set indent to 4 spaces for jq
		}), -- Added JSON formatter
	},
	on_attach = function(client, bufnr)
		-- Formatting setup
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({
				group = augroup,
				buffer = bufnr,
			})
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({ bufnr = bufnr })
				end,
			})
		end
	end,
}

return opts
