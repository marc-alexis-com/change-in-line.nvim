local core = require("change-in-line.core")

describe("find_quote_pairs", function()

	it("finds a simple pair", function()
		assert.same({{5, 11}}, core.find_quote_pairs('say "hello"'))
	end)

	it("finds multiple pairs", function()
		assert.same({{5, 11}, {17, 23}}, core.find_quote_pairs('say "hello" and "world"'))
	end)

	it("returns empty table when no quotes", function()
		assert.same({}, core.find_quote_pairs("no quotes here"))
	end)

	it("returns empty table when unclosed", function()
		assert.same({}, core.find_quote_pairs('"unclosed'))
	end)

	it("returns empty table for escaped quotes", function()
		assert.same({}, core.find_quote_pairs('\\"hello\\"'))
	end)

	it("finds pair starting at position 1", function()
		assert.same({{1, 7}}, core.find_quote_pairs('"hello"'))
	end)

	it("handles empty string", function()
		assert.same({}, core.find_quote_pairs(""))
	end)

end)

describe("find_closest_pair", function()

	it("returns nil when no pairs", function()
		assert.is_nil(core.find_closest_pair({}, 5))
	end)

	it("returns the pair when cursor is inside", function()
		local pairs = {{5, 11}}
		assert.same({5, 11}, core.find_closest_pair(pairs, 8))
	end)

	it("returns the pair when cursor is on opening quote", function()
		local pairs = {{5, 11}}
		assert.same({5, 11}, core.find_closest_pair(pairs, 5))
	end)

	it("returns the pair when cursor is on closing quote", function()
		local pairs = {{5, 11}}
		assert.same({5, 11}, core.find_closest_pair(pairs, 11))
	end)

	it("returns closest pair when cursor is outside", function()
		local pairs = {{1, 7}, {13, 19}}
		assert.same({1, 7}, core.find_closest_pair(pairs, 9))
	end)

	it("returns the only pair when cursor is before it", function()
		local pairs = {{10, 16}}
		assert.same({10, 16}, core.find_closest_pair(pairs, 1))
	end)

	it("returns the only pair when cursor is after it", function()
		local pairs = {{1, 7}}
		assert.same({1, 7}, core.find_closest_pair(pairs, 20))
	end)

end)
