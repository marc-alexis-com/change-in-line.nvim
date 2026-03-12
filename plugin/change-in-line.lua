if vim.g.loaded_change_in_line then
	return
end

vim.g.loaded_change_in_line = 1

local function map(lhs, action, open, close, desc)
	vim.keymap.set("n", lhs, function()
		require("change-in-line").change_in_pairs(action, open, close)
	end, { desc = desc, noremap = true })
end

-- double quotes
map('ci"', "i", '"', '"', 'Change inside " on current line')
map('ca"', "a", '"', '"', 'Change around " on current line')

-- single quotes
map("ci'", "i", "'", "'", "Change inside ' on current line")
map("ca'", "a", "'", "'", "Change around ' on current line")

-- backticks
map("ci`", "i", "`", "`", "Change inside ` on current line")
map("ca`", "a", "`", "`", "Change around ` on current line")

-- parentheses
map("ci(", "i", "(", ")", "Change inside () on current line")
map("ci)", "i", "(", ")", "Change inside () on current line")
map("ca(", "a", "(", ")", "Change around () on current line")
map("ca)", "a", "(", ")", "Change around () on current line")

-- curly braces
map("ci{", "i", "{", "}", "Change inside {} on current line")
map("ci}", "i", "{", "}", "Change inside {} on current line")
map("ca{", "a", "{", "}", "Change around {} on current line")
map("ca}", "a", "{", "}", "Change around {} on current line")

-- brackets
map("ci[", "i", "[", "]", "Change inside [] on current line")
map("ci]", "i", "[", "]", "Change inside [] on current line")
map("ca[", "a", "[", "]", "Change around [] on current line")
map("ca]", "a", "[", "]", "Change around [] on current line")

-- angle brackets
map("ci<", "i", "<", ">", "Change inside <> on current line")
map("ci>", "i", "<", ">", "Change inside <> on current line")
map("ca<", "a", "<", ">", "Change around <> on current line")
map("ca>", "a", "<", ">", "Change around <> on current line")
