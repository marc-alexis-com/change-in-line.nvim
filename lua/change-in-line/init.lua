local M = {}

function M.setup(opts)
	M.opts = opts or {}
end

local ns = vim.api.nvim_create_namespace("change-in-line")


local function show_labels(pairs, row, action, close_char)
	for i = 1, #pairs do
		-- limit label width to the space before any nested pair
		local available
		if i < #pairs and pairs[i + 1][1] < pairs[i][2] then
			available = pairs[i + 1][1] - pairs[i][1] - 1
		else
			available = pairs[i][2] - pairs[i][1] - 1
		end

		local label_left  = math.max(0, math.floor((available - 1) / 2))
		local label_right = math.max(0, available - 1 - label_left)
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
		if code == 27 or code == 58 then -- Esc or :
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
	vim.api.nvim_win_set_cursor(0, { row, pair[1] - 1 }) -- Neovim columns are 0-based

	vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)

	local keys = vim.api.nvim_replace_termcodes('c' .. action .. close_char, true, false, true)
	vim.api.nvim_feedkeys(keys, 'n', false)
end

local function pairs_at_col(pairs, col)
	local result = {}
	for _, pair in ipairs(pairs) do
		if col >= pair[1] and col <= pair[2] then
			table.insert(result, pair)
		end
	end
	return result
end

function M.change_in_pairs(action, open_char, close_char)
	local core = require("change-in-line.core")
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	col = col + 1 -- col is 0-based, add 1 for Lua 1-based indexing

	local line = vim.api.nvim_get_current_line()
	local pairs = core.find_pairs(line, open_char, close_char)

	if #pairs == 0 then
		vim.notify("No " .. open_char .. close_char .. " pair found :(", vim.log.levels.WARN)
		return
	end

	local containing = pairs_at_col(pairs, col)

	if #containing == 1 then
		vim.api.nvim_win_set_cursor(0, { row, containing[1][1] - 1 })
		local keys = vim.api.nvim_replace_termcodes('c' .. action .. close_char, true, false, true)
		vim.api.nvim_feedkeys(keys, 'n', false)
	elseif #containing > 1 then
		show_labels(containing, row, action, close_char)
	elseif #pairs == 1 then
		vim.api.nvim_win_set_cursor(0, { row, pairs[1][1] - 1 })
		local keys = vim.api.nvim_replace_termcodes('c' .. action .. close_char, true, false, true)
		vim.api.nvim_feedkeys(keys, 'n', false)
	else
		show_labels(pairs, row, action, close_char)
	end
end

return M
