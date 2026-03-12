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
				if char == open_char then
					if open_pos == nil then
						open_pos = i
					else
						table.insert(pairs, { open_pos, i })
						open_pos = nil
					end
				end
			else
				-- asymmetric: use a stack to handle nested pairs
				if char == open_char then
					table.insert(pairs, { i, nil }) -- push incomplete pair
				elseif char == close_char then
					-- find the last unclosed pair and close it
					for j = #pairs, 1, -1 do
						if pairs[j][2] == nil then
							pairs[j][2] = i
							break
						end
					end
				end
			end
		end
	end

	-- remove incomplete pairs (unclosed)
	local complete = {}
	for _, pair in ipairs(pairs) do
		if pair[2] ~= nil then
			table.insert(complete, pair)
		end
	end

	return complete
end

return M
