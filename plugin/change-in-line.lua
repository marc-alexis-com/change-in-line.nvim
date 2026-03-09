if vim.g.loaded_change_in_line then
	return
end

vim.g.loaded_change_in_line = 1

local plugin = require("change-in-line")

vim.keymap.set("n", "ci\"", function() plugin.change_in_quotes("i") end,
	{ desc = "change inside quote in current line", noremap = true })
vim.keymap.set("n", "ca\"", function() plugin.change_in_quotes("a") end,
	{ desc = "change outside quote in current line", noremap = true })
