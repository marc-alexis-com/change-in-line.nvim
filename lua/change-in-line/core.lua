local M = {}

function M.find_quote_pairs(line)
	local pairs = {}
	local open_pos = nil

	for i = 1, #line do
		local char = line:sub(i, i)
		if char == '"' then -- Currently only " supported (Plugin limitation)
			local prev = line:sub(i - 1, i - 1)
			local is_escaped = (prev == "\\") -- Escape if \ before "

			if not is_escaped then
				if open_pos == nil then
					open_pos = i
				else
					table.insert(pairs, {open_pos, i})
					open_pos = nil
				end
			end
		end
	end
	return pairs
end

function M.find_closest_pair(pairs, cursor_col)
	local best_pair = nil
	local best_dist = math.huge

	if #pairs == 0 then
		return nil
	end

	for i = 1, #pairs do
		if pairs[i][1] <= cursor_col and pairs[i][2] >= cursor_col then
			return pairs[i]
		else
			local a = math.abs(cursor_col - pairs[i][1])
			local b = math.abs(cursor_col - pairs[i][2])

			local dist = math.min(a, b)
			if dist < best_dist then
				best_dist = dist
				best_pair = pairs[i]
			end
		end
	end

	return best_pair
end

return M
