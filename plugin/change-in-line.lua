if vim.g.loaded_change_in_line then
	return
end

vim.g.loaded_change_in_line = 1

-- auto-setup with defaults if the user never called setup()
vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		local plugin = require("change-in-line")
		if not plugin.opts then
			plugin.setup({})
		end
	end,
})
