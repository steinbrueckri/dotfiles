-------------------------------------------------------------------------------
-- Autocommands
-------------------------------------------------------------------------------
-- Autocommand that sets numbers to relative in normal mode, absolute in insert
vim.api.nvim_create_autocmd({ "BufEnter", "FocusGained", "InsertLeave", "WinEnter" }, {
	pattern = "*",
	callback = function()
		if vim.wo.number and vim.fn.mode() ~= "i" then
			vim.wo.relativenumber = false
		end
	end,
})
vim.api.nvim_create_autocmd({ "BufLeave", "FocusLost", "InsertEnter", "WinLeave" }, {
	pattern = "*",
	callback = function()
		if vim.wo.number then
			vim.wo.relativenumber = true
		end
	end,
})

-- Autocommand that highlights on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	pattern = "*",
	callback = function()
		vim.hl.on_yank({ higroup = "IncSearch", timeout = 700 })
	end,
})

-- Keymap files (adv360) have long lines that must not wrap
vim.api.nvim_create_autocmd("FileType", {
	pattern = "keymap",
	callback = function()
		vim.wo.wrap = false
	end,
})

-- Restore the last cursor position when reopening a file (see :h last-position-jump)
-- Deferred to BufWinEnter: the filetype is not known yet on BufReadPost.
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function(args)
		vim.api.nvim_create_autocmd("BufWinEnter", {
			once = true,
			buffer = args.buf,
			callback = function()
				local ignore_filetypes = { "gitcommit", "gitrebase", "svn", "hgcommit" }
				if vim.bo[args.buf].buftype ~= "" or vim.tbl_contains(ignore_filetypes, vim.bo[args.buf].filetype) then
					return
				end
				local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
				if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(args.buf) then
					vim.api.nvim_win_set_cursor(0, mark)
					vim.cmd("normal! zv") -- open folds at the restored position
				end
			end,
		})
	end,
})

-- Move cursor to end of file when replying in aerc to prevent top-posting (TOFU)
vim.api.nvim_create_autocmd("BufWinEnter", {
	pattern = "*/aerc-*.eml",
	callback = function()
		vim.cmd("normal! G")
	end,
})

-- Slidev decks are edited as source, not as prose. Three things get in the way and
-- are turned off per buffer:
--   diagnostics -- rumdl and marksman flag heading levels that are correct on a slide
--   treesitter  -- Neovim's own ftplugin/markdown.lua starts it, styling headings
--   conceal     -- hides the `**` and HTML the deck is literally built from
-- LSP itself stays attached, so hover and goto still work.
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function(args)
		if not require("slidev").is_deck(args.buf) then
			return
		end
		vim.diagnostic.enable(false, { bufnr = args.buf })
		vim.opt_local.conceallevel = 0
		-- Deferred: both Neovim's ftplugin and tree-sitter-manager start the
		-- highlighter from their own FileType handlers, which run after this one.
		vim.schedule(function()
			if vim.api.nvim_buf_is_valid(args.buf) then
				vim.treesitter.stop(args.buf)
			end
		end)
	end,
})
