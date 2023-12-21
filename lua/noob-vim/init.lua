local M = {}
local string = require("string")

local map = {
	c = "//",
	lua = "--",
	java = "//",
}

function string.starts(String, Start)
	return string.sub(String, 1, string.len(Start)) == Start
end
function M.setup(opts)
	opts = opts or {}
	vim.keymap.set("n", "<Leader>c/", function()
		local line = vim.api.nvim_get_current_line()
		local trimmed = line:match("^%s*(.-)%s*$")
		local comment = map[vim.bo.filetype]
		if string.starts(trimmed, comment) then
			line = string.gsub(line, "^(" .. comment .. ")", "")
			vim.api.nvim_set_current_line(line)
		else
			line = comment .. line
			vim.api.nvim_set_current_line(line)
		end
	end, { noremap = true, silent = true, desc = "Comment line" })
end

return M
