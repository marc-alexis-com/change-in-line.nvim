local core = require("change-in-line.core")

describe("find_pairs", function()

	describe("double quotes", function()

		it("finds a simple pair", function()
			assert.same({{5, 11}}, core.find_pairs('say "hello"', '"', '"'))
		end)

		it("finds multiple pairs", function()
			assert.same({{5, 11}, {17, 23}}, core.find_pairs('say "hello" and "world"', '"', '"'))
		end)

		it("returns empty table when no quotes", function()
			assert.same({}, core.find_pairs("no quotes here", '"', '"'))
		end)

		it("returns empty table when unclosed", function()
			assert.same({}, core.find_pairs('"unclosed', '"', '"'))
		end)

		it("returns empty table for escaped quotes", function()
			assert.same({}, core.find_pairs('\\"hello\\"', '"', '"'))
		end)

		it("finds pair starting at position 1", function()
			assert.same({{1, 7}}, core.find_pairs('"hello"', '"', '"'))
		end)

		it("handles empty string", function()
			assert.same({}, core.find_pairs("", '"', '"'))
		end)

	end)

	describe("parentheses", function()

		it("finds a simple pair", function()
			assert.same({{4, 10}}, core.find_pairs("say(hello)", '(', ')'))
		end)

		it("finds multiple pairs", function()
			assert.same({{1, 7}, {9, 15}}, core.find_pairs("(hello) (world)", '(', ')'))
		end)

		it("returns empty table when unclosed", function()
			assert.same({}, core.find_pairs("(unclosed", '(', ')'))
		end)

	end)

end)

