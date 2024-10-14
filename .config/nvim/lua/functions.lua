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
