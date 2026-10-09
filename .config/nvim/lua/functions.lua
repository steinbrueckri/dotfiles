local M = {}

-- better quickfix list stuff
function M.toggle_qf()
	if vim.bo.filetype == "qf" then
		vim.cmd.cclose()
	else
		vim.cmd.copen()
	end
end

-------------------------------------------------------------------------------
-- silverbullet stuff
-------------------------------------------------------------------------------

local silverbullet_url = "http://localhost:3000/" -- Base URL for Silverbullet
local notes_base = os.getenv("HOME") .. "/notes/" -- Base directory for notes

-- function to create quick note
function M.create_quick_note()
	local timestamp = os.date("%Y-%m-%d/%H-%M-%S")
	local file_path = notes_base .. "notes/Inbox/" .. timestamp .. ".md"

	vim.fn.mkdir(vim.fs.dirname(file_path), "p")
	vim.cmd.edit(file_path)

	-- Write the filename as a Markdown header in the first line
	local header = "# " .. vim.fs.basename(file_path)
	vim.api.nvim_buf_set_lines(0, 0, 0, false, { header })
end

-- Function to open the current note in Silverbullet
function M.open_in_silverbullet()
	local file_path = vim.fn.expand("%:p")
	if file_path == "" then
		vim.notify("No file is currently open.", vim.log.levels.WARN)
		return
	end

	if not vim.startswith(file_path, notes_base) then
		vim.notify("Current file is not in the notes directory.", vim.log.levels.WARN)
		return
	end

	-- Strip the base directory and the .md extension to get the page name
	local page = file_path:sub(#notes_base + 1):gsub("%.md$", "")
	vim.ui.open(silverbullet_url .. page)
end

-- Tools like tofu and tflint are pinned per project with mise. Their shims exist
-- everywhere but fail outside such projects, so check that the tool really runs.
function M.tool_runs(cmd, dir)
	local ok, result = pcall(function()
		return vim.system(cmd, { cwd = dir }):wait()
	end)
	return ok and result.code == 0
end

-- Run a make target from the nearest Makefile in a terminal split
function M.make_targets()
	local makefile =
		vim.fs.find({ "Makefile", "makefile", "GNUmakefile" }, { upward = true, path = vim.fn.getcwd() })[1]
	if not makefile then
		vim.notify("No Makefile found", vim.log.levels.WARN)
		return
	end
	local make_dir = vim.fs.dirname(makefile)

	-- Every line starting with "target:" is a target; skip variables (:=) and special targets (.PHONY)
	local targets = {}
	for _, line in ipairs(vim.fn.readfile(makefile)) do
		local target = line:match("^([%w][%w_%-%./]*)%s*:[^=]") or line:match("^([%w][%w_%-%./]*)%s*:$")
		if target and not vim.tbl_contains(targets, target) then
			table.insert(targets, target)
		end
	end
	if #targets == 0 then
		vim.notify("No make targets in " .. makefile, vim.log.levels.WARN)
		return
	end

	vim.ui.select(targets, { prompt = "Make" }, function(target)
		if target then
			Snacks.terminal({ "make", "-C", make_dir, target }, { interactive = false, win = { position = "bottom" } })
		end
	end)
end

return M
