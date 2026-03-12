local M = {}

function M.find_pairs(line, open_char, close_char)
	local pairs = {}
	local open_pos = nil

	for i = 1, #line do
		local char = line:sub(i, i)

		local prev = line:sub(i - 1, i - 1)
		local is_escaped = (prev == "\\") -- Escaped if \ before char

		if not is_escaped then
			if open_char == close_char then
				if char == open_char then -- ← nouveau check !
					if open_pos == nil then
						open_pos = i
					else
						table.insert(pairs, { open_pos, i })
						open_pos = nil
					end
				end
			else
				if char == open_char then                    -- ← nouveau check !
					open_pos = i
				elseif char == close_char and open_pos ~= nil then -- ← nouveau check !
					table.insert(pairs, { open_pos, i })
					open_pos = nil
				end
			end
		end
	end
	return pairs
end

return M
