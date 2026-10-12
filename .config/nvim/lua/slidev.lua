-------------------------------------------------------------------------------
-- Slidev deck detection
-------------------------------------------------------------------------------
-- Slidev decks are presentations, not documents: their frontmatter, the `---`
-- slide separators and the inline HTML are hand-crafted. Formatters rewrite
-- them and markdown linters complain about heading levels that are correct for
-- a slide, so both are turned off for these buffers.

local M = {}

local frontmatter_keys = {
	"theme",
	"transition",
	"mdc",
	"layout",
	"drawings",
	"colorSchema",
	"canvasWidth",
	"lineNumbers",
	"hideInToc",
}

-- A deck opens with a YAML frontmatter block carrying at least one Slidev key.
local function has_slidev_frontmatter(bufnr)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 30, false)
	if lines[1] ~= "---" then
		return false
	end
	for i = 2, #lines do
		if lines[i] == "---" then
			return false -- frontmatter ended without a Slidev key
		end
		local key = lines[i]:match("^(%w+):")
		if key and vim.tbl_contains(frontmatter_keys, key) then
			return true
		end
	end
	return false
end

-- Catches decks without telling frontmatter: the nearest package.json wants Slidev.
local function in_slidev_project(bufnr)
	local name = vim.api.nvim_buf_get_name(bufnr)
	if name == "" then
		return false
	end
	local manifest = vim.fs.find("package.json", { path = vim.fs.dirname(name), upward = true })[1]
	if not manifest then
		return false
	end
	local ok, content = pcall(vim.fn.readfile, manifest)
	return ok and table.concat(content, "\n"):find("@slidev/", 1, true) ~= nil
end

function M.is_deck(bufnr)
	if vim.bo[bufnr].filetype ~= "markdown" then
		return false
	end
	return has_slidev_frontmatter(bufnr) or in_slidev_project(bufnr)
end

return M
