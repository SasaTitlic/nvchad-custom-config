local plugins = {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"gopls",
				"gofumpt",
				"goimports",
				"golangci-lint",
				"golangci-lint-langserver",
				"golines",
				"gopls",
				"go-debug-adapter",
				"stylua",
			},
		},
	},
	{
		"mfussenegger/nvim-dap",
		init = function()
			require("core.utils").load_mappings("dap")
		end,
	},
	{
		"dreamsofcode-io/nvim-dap-go",
		ft = "go",
		dependencies = "mfussenegger/nvim-dap",
		config = function(_, opts)
			require("dap-go").setup(opts)
			require("core.utils").load_mappings("dap_go")
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			-- Add fidget.nvim as a dependency
			{
				"j-hui/fidget.nvim",
				opts = {},
			},
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			require("plugins.configs.lspconfig")
			require("custom.configs.lspconfig")
		end,
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		ft = { "go", "lua" },
		opts = function()
			return require("custom.configs.null-ls")
		end,
	},
	{
		"olexsmir/gopher.nvim",
		ft = "go",
		config = function(_, opts)
			require("gopher").setup(opts)
			require("core.utils").load_mappings("gopher")
		end,
		build = function()
			vim.cmd([[silent! GoInstallDeps]])
		end,
	},
	{
		"fatih/vim-go",
		ft = "go",
		config = function()
			vim.cmd([[
        let g:go_fmt_command = "gopls"  " or gofumpt
        let g:go_imports_mode = "goimports"  " or goimports_reviser
      ]])
		end,
		build = ":GoInstallBinaries",
	},
	{
		"lewis6991/gitsigns.nvim",
		lazy = false,
		config = function()
			require("gitsigns").setup()
		end,
	},
	{
		"tpope/vim-fugitive",
		lazy = false,
		cmd = { "Git", "Gvdiffsplit" },
	},
	{
		"ThePrimeagen/vim-be-good",
		cmd = "VimBeGood",
		lazy = true,
	},
	-- {
	--   "stevearc/oil.nvim",
	--   opts = {},
	--   -- Lazy load oil.nvim on VimEnter
	--   lazy = false,
	--   config = function()
	--     require("oil").setup({
	--       -- Oil-specific mappings
	--       keymaps = {
	--         ["g?"] = "actions.show_help",
	--         ["<CR>"] = "actions.select",
	--         ["<C-v>"] = "actions.select_vsplit",
	--         ["<C-h>"] = "actions.select_split",
	--         ["<C-t>"] = "actions.select_tab",
	--         ["<C-p>"] = "actions.preview",
	--         ["<C-c>"] = "actions.close",
	--         ["<C-r>"] = "actions.refresh",
	--         ["-"] = "actions.parent",
	--         ["_"] = "actions.open_cwd",
	--         ["`"] = "actions.cd",
	--         ["~"] = "actions.tcd",
	--         ["gs"] = "actions.change_sort",
	--         ["gx"] = "actions.open_external",
	--         ["g."] = "actions.toggle_hidden",
	--       },
	--       -- You can add more Oil-specific configurations here
	--     })
	--   end,
	-- },
	{
		"mg979/vim-visual-multi",
		lazy = false,
	},
	{
		"nvim-telescope/telescope.nvim",
		opts = function(_, opts)
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<C-t>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
					n = {
						["<C-t>"] = actions.send_selected_to_qflist + actions.open_qflist,
					},
				},
			})
			opts.pickers = {
				lsp_document_symbols = {
					symbol_width = 50, -- Adjust this value to change symbol name display width
					layout_config = {
						preview_width = 0.65,
					},
					symbol_type_width = 15, -- Width of the symbol type column
				},
			}
			return opts
		end,
	},
	{
		"MattesGroeger/vim-bookmarks",
		lazy = false,
	},
	{
		"sindrets/diffview.nvim",
		lazy = false,
		config = function()
			require("diffview").setup({
				-- Add any custom configuration here
			})
		end,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "moon",
		},
		config = function()
			vim.cmd([[colorscheme tokyonight-moon]])
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			routes = {
				{
					filter = { event = "notify", find = "No information available" },
					opts = { skip = true },
				},
				{
					view = "notify",
					filter = { event = "msg_showmode" },
				},
			},
			presets = {
				lsp_doc_border = true,
			},
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
				hover = {
					enabled = false,
				},
				signature = {
					enabled = false,
				},
			},
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function(_, opts)
			require("noice").setup(opts)
			require("core.utils").load_mappings("noice")
		end,
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = {
			dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"), -- directory where session files are saved
			options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
			pre_save = nil, -- a function to call before saving the session
			save_empty = false, -- don't save if there are no open file buffers
		},
		config = function(_, opts)
			require("persistence").setup(opts)
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("custom.configs.luasnip")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = { "lua", "vim", "vimdoc", "go" }, -- add any other languages you use frequently
			highlight = {
				enable = true,
			},
			indent = { enable = true },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<leader>ss",
					node_incremental = "<leader>si",
					scope_incremental = "<leader>sc",
					node_decremental = "<leader>sd",
				},
			},
		},
	},
}

return plugins
