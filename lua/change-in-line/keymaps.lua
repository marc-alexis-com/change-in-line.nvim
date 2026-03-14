local M = {}

local function map(lhs, operator, action, open, close, desc)
	vim.keymap.set("n", lhs, function()
		require("change-in-line").operate_on_pairs(operator, action, open, close)
	end, { desc = desc, noremap = true })
end

function M.register()
	-- double quotes
	map('ci"', "c", "i", '"', '"', 'Change inside " on current line')
	map('ca"', "c", "a", '"', '"', 'Change around " on current line')
	map('di"', "d", "i", '"', '"', 'Delete inside " on current line')
	map('da"', "d", "a", '"', '"', 'Delete around " on current line')
	map('yi"', "y", "i", '"', '"', 'Yank inside " on current line')
	map('ya"', "y", "a", '"', '"', 'Yank around " on current line')

	-- single quotes
	map("ci'", "c", "i", "'", "'", "Change inside ' on current line")
	map("ca'", "c", "a", "'", "'", "Change around ' on current line")
	map("di'", "d", "i", "'", "'", "Delete inside ' on current line")
	map("da'", "d", "a", "'", "'", "Delete around ' on current line")
	map("yi'", "y", "i", "'", "'", "Yank inside ' on current line")
	map("ya'", "y", "a", "'", "'", "Yank around ' on current line")

	-- backticks
	map("ci`", "c", "i", "`", "`", "Change inside ` on current line")
	map("ca`", "c", "a", "`", "`", "Change around ` on current line")
	map("di`", "d", "i", "`", "`", "Delete inside ` on current line")
	map("da`", "d", "a", "`", "`", "Delete around ` on current line")
	map("yi`", "y", "i", "`", "`", "Yank inside ` on current line")
	map("ya`", "y", "a", "`", "`", "Yank around ` on current line")

	-- parentheses
	map("ci(", "c", "i", "(", ")", "Change inside () on current line")
	map("ci)", "c", "i", "(", ")", "Change inside () on current line")
	map("ca(", "c", "a", "(", ")", "Change around () on current line")
	map("ca)", "c", "a", "(", ")", "Change around () on current line")
	map("di(", "d", "i", "(", ")", "Delete inside () on current line")
	map("di)", "d", "i", "(", ")", "Delete inside () on current line")
	map("da(", "d", "a", "(", ")", "Delete around () on current line")
	map("da)", "d", "a", "(", ")", "Delete around () on current line")
	map("yi(", "y", "i", "(", ")", "Yank inside () on current line")
	map("yi)", "y", "i", "(", ")", "Yank inside () on current line")
	map("ya(", "y", "a", "(", ")", "Yank around () on current line")
	map("ya)", "y", "a", "(", ")", "Yank around () on current line")

	-- curly braces
	map("ci{", "c", "i", "{", "}", "Change inside {} on current line")
	map("ci}", "c", "i", "{", "}", "Change inside {} on current line")
	map("ca{", "c", "a", "{", "}", "Change around {} on current line")
	map("ca}", "c", "a", "{", "}", "Change around {} on current line")
	map("di{", "d", "i", "{", "}", "Delete inside {} on current line")
	map("di}", "d", "i", "{", "}", "Delete inside {} on current line")
	map("da{", "d", "a", "{", "}", "Delete around {} on current line")
	map("da}", "d", "a", "{", "}", "Delete around {} on current line")
	map("yi{", "y", "i", "{", "}", "Yank inside {} on current line")
	map("yi}", "y", "i", "{", "}", "Yank inside {} on current line")
	map("ya{", "y", "a", "{", "}", "Yank around {} on current line")
	map("ya}", "y", "a", "{", "}", "Yank around {} on current line")

	-- brackets
	map("ci[", "c", "i", "[", "]", "Change inside [] on current line")
	map("ci]", "c", "i", "[", "]", "Change inside [] on current line")
	map("ca[", "c", "a", "[", "]", "Change around [] on current line")
	map("ca]", "c", "a", "[", "]", "Change around [] on current line")
	map("di[", "d", "i", "[", "]", "Delete inside [] on current line")
	map("di]", "d", "i", "[", "]", "Delete inside [] on current line")
	map("da[", "d", "a", "[", "]", "Delete around [] on current line")
	map("da]", "d", "a", "[", "]", "Delete around [] on current line")
	map("yi[", "y", "i", "[", "]", "Yank inside [] on current line")
	map("yi]", "y", "i", "[", "]", "Yank inside [] on current line")
	map("ya[", "y", "a", "[", "]", "Yank around [] on current line")
	map("ya]", "y", "a", "[", "]", "Yank around [] on current line")

	-- angle brackets
	map("ci<", "c", "i", "<", ">", "Change inside <> on current line")
	map("ci>", "c", "i", "<", ">", "Change inside <> on current line")
	map("ca<", "c", "a", "<", ">", "Change around <> on current line")
	map("ca>", "c", "a", "<", ">", "Change around <> on current line")
	map("di<", "d", "i", "<", ">", "Delete inside <> on current line")
	map("di>", "d", "i", "<", ">", "Delete inside <> on current line")
	map("da<", "d", "a", "<", ">", "Delete around <> on current line")
	map("da>", "d", "a", "<", ">", "Delete around <> on current line")
	map("yi<", "y", "i", "<", ">", "Yank inside <> on current line")
	map("yi>", "y", "i", "<", ">", "Yank inside <> on current line")
	map("ya<", "y", "a", "<", ">", "Yank around <> on current line")
	map("ya>", "y", "a", "<", ">", "Yank around <> on current line")
end

return M
