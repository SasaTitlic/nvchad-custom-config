local M = {}

M.dap = {
	plugin = true,
	n = {
		["<leader>db"] = {
			"<cmd> DapToggleBreakpoint <CR>",
			"Add breakpoint at line",
		},
		["<leader>dus"] = {
			function()
				local widgets = require("dap.ui.widgets")
				local sidebar = widgets.sidebar(widgets.scopes)
				sidebar.open()
			end,
			"Open debugging sidebar",
		},
	},
}

M.dap_go = {
	plugin = true,
	n = {
		["<leader>dgt"] = {
			function()
				require("dap-go").debug_test()
			end,
			"Debug go test",
		},
		["<leader>dgl"] = {
			function()
				require("dap-go").debug_last()
			end,
			"Debug last go test",
		},
	},
}

M.gopher = {
	plugin = true,
	n = {
		["<leader>gsj"] = {
			"<cmd> GoTagAdd json <CR>",
			"Add json struct tags",
		},
		["<leader>gsy"] = {
			"<cmd> GoTagAdd yaml <CR>",
			"Add yaml struct tags",
		},
	},
}

M.telescope = {
	n = {
		["<leader>fr"] = {
			function()
				require("telescope.builtin").lsp_references()
			end,
			"Find references using Telescope",
		},
	},
}

M.general = {
	n = {
		["<C-u>"] = { "<C-u>zz", "Scroll up half a page and center" },
		["<C-d>"] = { "<C-d>zz", "Scroll down half a page and center" },
		["<leader>rp"] = {
			function()
				local relative_path = vim.fn.expand("%")
				print(relative_path)
				vim.fn.setreg("+", relative_path)
				vim.notify("Relative path copied to clipboard: " .. relative_path, vim.log.levels.INFO)
			end,
			"Show and copy relative path",
		},
	},
}

M.fugitive = {
	n = {
		["<leader>gb"] = { "<cmd>Git blame<CR>", "Git blame" },
	},
}

M.visual_multi = {
	plugin = true,
	n = {
		["<Leader>vm"] = { "<Plug>(vm-start-find-under)", "Start VM with word under cursor" },
		["<Leader>vM"] = { "<Plug>(vm-select-all)", "Select all occurrences of word under cursor" },
	},
	x = {
		["<Leader>vm"] = { "<Plug>(vm-find-subword-under)", "Start VM with visual selection" },
	},
}

M.lsp = {
	n = {
		["<leader>@"] = {
			function()
				require("telescope.builtin").lsp_document_symbols()
			end,
			"List document symbols",
		},
		["<leader>e"] = {
			function()
				vim.diagnostic.open_float(nil, { scope = "line" })
			end,
			"Show diagnostic in floating window",
		},
	},
}

M.noice = {
	plugin = true,
	n = {
		["<leader>nd"] = {
			function()
				require("noice").cmd("dismiss")
			end,
			"Dismiss Noice Message",
		},
	},
}
M.persistence = {
	n = {
		["<leader>sr"] = {
			function()
				require("persistence").load()
			end,
			"Restore Session",
		},
		["<leader>sl"] = {
			function()
				require("persistence").load({ last = true })
			end,
			"Restore Last Session",
		},
		["<leader>sq"] = {
			function()
				require("persistence").stop()
			end,
			"Don't Save Current Session",
		},
	},
}
M.json_lsp = {
	n = {
		["<leader>jf"] = { "za", "Toggle JSON fold" },
		["<leader>jF"] = { "zA", "Toggle JSON fold recursively" },
		["<leader>jc"] = { "zM", "Close all JSON folds" },
		["<leader>jo"] = { "zR", "Open all JSON folds" },
	},
}

return M
