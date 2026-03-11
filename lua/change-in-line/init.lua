local M = {}

function M.setup(opts)
	M.opts = opts or {}
end

local ns = vim.api.nvim_create_namespace("change-in-line")


local function show_labels(pairs, row, action)
	for i = 1, #pairs do
		local mid         = math.floor((pairs[i][1] + pairs[i][2]) / 2)
		local label_left  = mid - pairs[i][1] - 1
		local label_right = pairs[i][2] - mid - 1
		local label_text  = string.rep("~", label_left) .. tostring(i) ..
			string.rep("~", label_right)

		vim.api.nvim_buf_set_extmark(0, ns, row - 1, pairs[i][1], {
			virt_text = { { label_text, "WarningMsg" } },
			virt_text_pos = "overlay",
		})
	end

	vim.cmd("redraw")

	local choice = nil
	while choice == nil do
		local code = vim.fn.getchar()
		if code == 27 or code == 58 then -- escape and : key ascii value
			vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
			return
		end

		local char = vim.fn.nr2char(code)
		local index = tonumber(char)

		if index and index >= 1 and index <= #pairs then
			choice = index
		end
	end

	local pair = pairs[choice]
	vim.api.nvim_win_set_cursor(0, { row, pair[1] - 1 }) -- match neovim 0-based collumn

	vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

	local keys = vim.api.nvim_replace_termcodes('c' .. action .. '"', true, false, true)
	vim.api.nvim_feedkeys(keys, 'n', false)
end

function M.change_in_quotes(action)
	local core = require("change-in-line.core")
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	col = col + 1 -- col is 0-based so add 1 to fit lua's array

	local line = vim.api.nvim_get_current_line()
	local pairs = core.find_quote_pairs(line)

	if #pairs == 0 then
		vim.notify("No \" pair found :(", vim.log.levels.WARN)
		return
	elseif #pairs == 1 then
		vim.api.nvim_win_set_cursor(0, { row, pairs[1][1] - 1 }) -- match neovim 0-based collumn

		local keys = vim.api.nvim_replace_termcodes('c' .. action .. '"', true, false, true)
		vim.api.nvim_feedkeys(keys, 'n', false)
	else
		show_labels(pairs, row, action)
	end
end

return M
