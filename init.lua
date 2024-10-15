-- In your chadrc.lua or a new file like custom/init.lua:

local opt = vim.opt

-- Enable relative line numbers
opt.relativenumber = true
opt.number = true -- This enables hybrid line numbers (current line shows absolute number)

-- You can add more core settings here if needed
-- For example:
-- opt.scrolloff = 8  -- Start scrolling when 8 lines from top or bottom
-- opt.sidescrolloff = 8  -- Start scrolling when 8 columns from left or right
-- opt.wrap = false  -- Disable line wrap

-- If you want to ensure these settings are applied after NvChad's defaults:
local autocmd = vim.api.nvim_create_autocmd
autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		opt.relativenumber = true
		opt.number = true
	end,
})

vim.api.nvim_create_user_command("CdInBufDir", 'execute "lcd %:p:h"', {})

vim.cmd("source " .. vim.fn.stdpath("config") .. "/lua/custom/commands.vim")

vim.opt.termguicolors = true
vim.o.tabstop = 4 -- A TAB character looks like 4 spaces
vim.o.expandtab = true -- Pressing the TAB key will insert spaces instead of a TAB character
vim.o.softtabstop = 4 -- Number of spaces inserted instead of a TAB character
vim.o.shiftwidth = 4 -- Number of spaces inserted when indenting
vim.opt.clipboard = "unnamedplus"
vim.g.neovide_transparency = 0.9

vim.api.nvim_create_user_command("OpenQuickfixBuffers", function()
	local qf_list = vim.fn.getqflist()
	for _, item in ipairs(qf_list) do
		if item.bufnr ~= 0 then
			local filepath = vim.api.nvim_buf_get_name(item.bufnr)
			vim.cmd("edit " .. vim.fn.fnameescape(filepath))
		end
	end
	vim.fn.setqflist({}) -- Clear the quickfix list
	vim.cmd("cclose") -- Close the quickfix window if it's open
	vim.cmd("wincmd k") -- Move to the upper window
	vim.cmd("close")
	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		local buf_name = vim.api.nvim_buf_get_name(bufnr)
		local buf_listed = vim.bo[bufnr].buflisted
		if buf_name == "" and buf_listed then
			vim.api.nvim_buf_delete(bufnr, { force = true })
			break -- Assume there's only one "No Name" buffer
		end
	end
	print("Opened " .. #qf_list .. " files from quickfix list and cleared it.")
end, {})
vim.api.nvim_create_user_command("DebugAutocmds", function()
	print("Autocommands that might affect normal mode:")
	vim.cmd("autocmd CursorMoved,CursorMovedI,InsertEnter,InsertLeave")
end, {})

-- Configure diagnostic display
vim.diagnostic.config({
	virtual_text = false, -- Disable virtual text
	signs = true, -- Show signs
	update_in_insert = false, -- Don't update diagnostics in insert mode
	underline = true, -- Use underline for diagnostics
	severity_sort = true, -- Sort diagnostics by severity
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "if_many",
		header = "",
		prefix = "",
	},
})

-- Show diagnostics in a floating window when holding the cursor
vim.o.updatetime = 250
vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {focus=false})]])
vim.api.nvim_create_user_command("Term", "terminal cd %:p:h && $SHELL", {})
