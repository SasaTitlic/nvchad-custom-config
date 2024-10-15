local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")
local util = require("lspconfig/util")

lspconfig.gopls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = util.root_pattern("go.work", "go.mod", ".git"),
	settings = {
		gopls = {
			completeUnimported = true,
			usePlaceholders = true,
			analyses = {
				unusedparams = true,
			},
		},
	},
})

-- lspconfig.lua_ls.setup({
-- 	on_attach = function(client, bufnr)
-- 		print("Lua LSP attached to buffer", bufnr)
-- 		on_attach(client, bufnr)
-- 	end,
-- 	capabilities = capabilities,
-- 	settings = {
-- 		Lua = {
-- 			runtime = {
-- 				version = "LuaJIT",
-- 			},
-- 			diagnostics = {
-- 				globals = { "vim" },
-- 			},
-- 			workspace = {
-- 				library = vim.api.nvim_get_runtime_file("", true),
-- 				checkThirdParty = false,
-- 			},
-- 			telemetry = {
-- 				enable = false,
-- 			},
-- 		},
-- 	},
-- })
