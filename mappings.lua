local M = {}

M.dap = {
  plugin = true,
  n = {
    ["<leader>db"] = {
      "<cmd> DapToggleBreakpoint <CR>",
      "Add breakpoint at line"
    },
    ["<leader>dus"] = {
      function ()
        local widgets = require('dap.ui.widgets');
        local sidebar = widgets.sidebar(widgets.scopes);
        sidebar.open();
      end,
      "Open debugging sidebar"
    }
  }
}

M.dap_go = {
  plugin = true,
  n = {
    ["<leader>dgt"] = {
      function()
        require('dap-go').debug_test()
      end,
      "Debug go test"
    },
    ["<leader>dgl"] = {
      function()
        require('dap-go').debug_last()
      end,
      "Debug last go test"
    }
  }
}

M.gopher = {
  plugin = true,
  n = {
    ["<leader>gsj"] = {
      "<cmd> GoTagAdd json <CR>",
      "Add json struct tags"
    },
    ["<leader>gsy"] = {
      "<cmd> GoTagAdd yaml <CR>",
      "Add yaml struct tags"
    },
    ["<leader>gi"] = {
      "<cmd>GoFuzzyImport<CR>",
      "Go Import (fuzzy search)"
    }
  }
}

M.telescope = {
  n = {
    ["<leader>fr"] = {
      function()
        require('telescope.builtin').lsp_references()
      end,
      "Find references using Telescope"
    }
  }
}

M.general = {
  n = {
    ["<C-u>"] = { "<C-u>zz", "Scroll up half a page and center" },
    ["<C-d>"] = { "<C-d>zz", "Scroll down half a page and center" },
  }
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

return M
