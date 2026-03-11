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

return M
