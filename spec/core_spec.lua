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

	describe("single quotes", function()

		it("finds a simple pair", function()
			assert.same({{5, 11}}, core.find_pairs("say 'hello'", "'", "'"))
		end)

		it("returns empty table for escaped quotes", function()
			assert.same({}, core.find_pairs("\\'hello\\'", "'", "'"))
		end)

		it("finds multiple pairs", function()
			assert.same({{1, 7}, {9, 15}}, core.find_pairs("'hello' 'world'", "'", "'"))
		end)

	end)

	describe("backticks", function()

		it("finds a simple pair", function()
			assert.same({{5, 11}}, core.find_pairs("say `hello`", "`", "`"))
		end)

		it("finds multiple pairs", function()
			assert.same({{1, 7}, {9, 15}}, core.find_pairs("`hello` `world`", "`", "`"))
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

		it("finds pair at start of line", function()
			assert.same({{1, 7}}, core.find_pairs("(hello)", '(', ')'))
		end)

	end)

	describe("curly braces", function()

		it("finds a simple pair", function()
			assert.same({{4, 10}}, core.find_pairs("say{hello}", '{', '}'))
		end)

		it("finds multiple pairs", function()
			assert.same({{1, 7}, {9, 15}}, core.find_pairs("{hello} {world}", '{', '}'))
		end)

		it("returns empty table when unclosed", function()
			assert.same({}, core.find_pairs("{unclosed", '{', '}'))
		end)

	end)

	describe("brackets", function()

		it("finds a simple pair", function()
			assert.same({{4, 10}}, core.find_pairs("say[hello]", '[', ']'))
		end)

		it("finds multiple pairs", function()
			assert.same({{1, 7}, {9, 15}}, core.find_pairs("[hello] [world]", '[', ']'))
		end)

	end)

	describe("angle brackets", function()

		it("finds a simple pair", function()
			assert.same({{4, 10}}, core.find_pairs("say<hello>", '<', '>'))
		end)

		it("finds multiple pairs", function()
			assert.same({{1, 7}, {9, 15}}, core.find_pairs("<hello> <world>", '<', '>'))
		end)

	end)

	describe("nested pairs", function()

		it("finds both inner and outer pairs", function()
			-- foo(bar(baz)) → outer {4,13} first, inner {8,12} second (ordered by open position)
			assert.same({{4, 13}, {8, 12}}, core.find_pairs("foo(bar(baz))", '(', ')'))
		end)

		it("finds all levels in triple nesting", function()
			-- (a(b(c))) → ordered by open position: {1,9}, {3,8}, {5,7}
			assert.same({{1, 9}, {3, 8}, {5, 7}}, core.find_pairs("(a(b(c)))", '(', ')'))
		end)

		it("finds sibling and nested pairs", function()
			-- (a) (b(c)) → {1,3}, {5,10}, {7,9}
			assert.same({{1, 3}, {5, 10}, {7, 9}}, core.find_pairs("(a) (b(c))", '(', ')'))
		end)

	end)

	describe("edge cases", function()

		it("handles empty pair content", function()
			assert.same({{1, 2}}, core.find_pairs('""', '"', '"'))
		end)

		it("handles empty pair content asymmetric", function()
			assert.same({{1, 2}}, core.find_pairs("()", '(', ')'))
		end)

		it("pair at end of line", function()
			assert.same({{9, 15}}, core.find_pairs('blah bla"hello"', '"', '"'))
		end)

		it("multiple pair types on same line only finds the right one", function()
			assert.same({{1, 7}}, core.find_pairs('"hello" (world)', '"', '"'))
			assert.same({{9, 15}}, core.find_pairs('"hello" (world)', '(', ')'))
		end)

		-- known limitation: escaped backslash before quote is not handled
		-- '\\"hello"' should find {3,9} but currently returns {}
		it("known bug: escaped backslash before quote", function()
			assert.same({}, core.find_pairs('\\\\"hello"', '"', '"'))
		end)

	end)

end)

