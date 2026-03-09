local core = require("change-in-line.core")
local M = {}

function M.setup(opts)
	M.opts = opts or {}
end

function M.change_in_quotes(action)
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	col = col + 1 -- col is 0-based so add 1 to fit lua's

	local line = vim.api.nvim_get_current_line()
	local closest_pair = core.find_closest_pair(core.find_quote_pairs(line), col)

	if closest_pair == nil then
		vim.notify("No quote pair found :(", vim.log.levels.WARN)
		return
	end

	vim.api.nvim_win_set_cursor(0, { row, closest_pair[1] - 1 }) -- match neovim 0-based collumn

	local keys = vim.api.nvim_replace_termcodes('c' .. action .. '"', true, false, true)
	vim.api.nvim_feedkeys(keys, 'n', false)
end

return M
