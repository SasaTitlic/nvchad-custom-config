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
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    init = function()
      require("core.utils").load_mappings("dap")
    end
  },
  {
    "dreamsofcode-io/nvim-dap-go",
    ft = "go",
    dependencies = "mfussenegger/nvim-dap",
    config = function(_, opts)
      require("dap-go").setup(opts)
      require("core.utils").load_mappings("dap_go")
    end
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
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },
  {
    "jose-elias-alvarez/null-ls.nvim",
    ft = "go",
    opts = function ()
     return require "custom.configs.null-ls"
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
      vim.cmd [[silent! GoInstallDeps]]
    end,
  },
  {
    "fatih/vim-go",
    ft = "go",
    config = function()
      vim.cmd [[
        let g:go_fmt_command = "gopls"  " or gofumpt
        let g:go_imports_mode = "goimports"  " or goimports_reviser
      ]]
    end,
    build = ':GoInstallBinaries'
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
    cmd = {"Git", "Gvdiffsplit"},
  },
  {
    "ThePrimeagen/vim-be-good",
    cmd = "VimBeGood",
    lazy = true,
  },
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Lazy load oil.nvim on VimEnter
    lazy = false,
    config = function()
      require("oil").setup({
        -- Oil-specific mappings
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-v>"] = "actions.select_vsplit",
          ["<C-h>"] = "actions.select_split",
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-r>"] = "actions.refresh",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
        },
        -- You can add more Oil-specific configurations here
      })
    end,
  },
  {
    "mg979/vim-visual-multi",
    lazy = false,
  }
}

return plugins
