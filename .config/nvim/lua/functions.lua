-- function to help for debugging
function dump(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

-- better quickfix list stuff
function toggleQf()
	local ft = vim.bo.filetype
	if ft == "qf" then
		vim.cmd.cclose()
	else
		vim.cmd.copen()
	end
end

-- Configurable variables
local silverbullet_url = "http://localhost:3000/" -- Base URL for Silverbullet
local notes_base = os.getenv("HOME") .. "/notes/" -- Base directory for notes

-- function to create quick note
function CreateQuickNote()
    -- Get the current timestamp
    local timestamp = os.date("%Y-%m-%d/%H-%M-%S")
    -- Build the file path
    local notes_dir = notes_base .. "/notes/Inbox/"
    local file_path = notes_dir .. timestamp .. ".md"

    -- Ensure the directory structure exists
    vim.fn.system({ "mkdir", "-p", vim.fn.fnamemodify(file_path, ":h") })

    -- Open the file in the current buffer
    vim.cmd("e " .. file_path)

    -- Write the filename as the first line in the buffer
    local buf = vim.api.nvim_get_current_buf()
    local header = "# " .. vim.fn.fnamemodify(file_path, ":t") -- Adds the filename as a Markdown header
    vim.api.nvim_buf_set_lines(buf, 0, 0, false, { header }) -- Inserts at the beginning of the buffer
end

-- Function to open the current note in Silverbullet
function OpenInSilverbullet()
    -- Get the absolute path of the current file
    local file_path = vim.fn.expand("%:p")
    if file_path == "" then
        print("No file is currently open.")
        return
    end

    -- Check if the file is within the notes directory
    if not file_path:find(notes_base, 1, true) then
        print("Current file is not in the notes directory.")
        return
    end

    -- Generate the relative path and the Silverbullet URL
    local relative_path = file_path:gsub(notes_base, ""):gsub("%.md$", "") -- Remove base directory and .md extension
    local full_url = silverbullet_url .. relative_path

    -- Open the URL in the default browser
    vim.fn.jobstart({ "open", full_url }, { detach = true })
end
