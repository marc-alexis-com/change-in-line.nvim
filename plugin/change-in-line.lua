if vim.g.loaded_change_in_line then
	return
end

vim.g.loaded_change_in_line = 1

vim.keymap.set("n", "ci\"", function() require("change-in-line").change_in_quotes("i") end,
	{ desc = "change inside quote on current line", noremap = true })
vim.keymap.set("n", "ca\"", function() require("change-in-line").change_in_quotes("a") end,
	{ desc = "change around quote on current line", noremap = true })
