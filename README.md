# change-in-line.nvim

Neovim plugin that makes `ci`/`ca`, `di`/`da`, and `yi`/`ya` work on the current line (even when your cursor is not inside a pair).

![](assets/demo.gif)

## Features

- Works with `"`, `'`, `` ` ``, `(`, `{`, `[`, `<`
- Already inside a pair → acts directly, no labels
- Only 1 pair on the line → acts directly, no labels
- Multiple pairs on the line → displays numbered labels over each pair, press the number to act on it, `Esc` to cancel
- Nested pairs → labels shown for each level, cursor inside multiple pairs also triggers label mode
- Ignores escaped characters (`\"`, `\'`...)

## Installation

With lazy.nvim:

```lua
{
  "marc-alexis-com/change-in-line.nvim",
  config = function()
    require("change-in-line").setup()
  end,
}
```

## Usage

| Operator | Variants | Delimiters |
|----------|----------|------------|
| `c` (change) | `ci"`, `ca"` | `"` `'` `` ` `` `(` `{` `[` `<` |
| `d` (delete) | `di"`, `da"` | `"` `'` `` ` `` `(` `{` `[` `<` |
| `y` (yank)   | `yi"`, `ya"` | `"` `'` `` ` `` `(` `{` `[` `<` |

`i` = inside (excludes delimiters) — `a` = around (includes delimiters)

## Configuration

All options are optional. Defaults shown below:

```lua
require("change-in-line").setup({
  -- set to false to disable all default keymaps
  keymaps = true,

  -- highlight group used for the labels
  highlight = "WarningMsg",

  -- character used to fill the label background
  filler = "~",
})
```

### Disable default keymaps

```lua
require("change-in-line").setup({ keymaps = false })
```

You can then define your own mappings:

```lua
vim.keymap.set("n", 'ci"', function()
  require("change-in-line").operate_on_pairs("c", "i", '"', '"')
end)
```

## Known Limitations

- Lines mixing escaped `\"` and regular `"` may produce unexpected results (Neovim's native `ci"` does not handle escaped quotes either)
- Labels are numbered 1–9, so only up to 9 pairs can be selected at once on the same line
- `ci<` handles literal `<>` pairs, not HTML/XML tags (use `cit` for tags)
- `'` support may conflict with apostrophes in natural language text

## Roadmap

- [x] Label mode to choose between multiple pairs
- [x] No labels when already inside a pair
- [x] Support `"`, `'`, `` ` ``, `(`, `{`, `[`, `<`
- [x] Stack-based detection for nested pairs like `(foo(bar))`
- [x] Support `di`/`da` and `yi`/`ya`
- [x] Configurable highlight group and filler character
- [ ] Treesitter integration for context-aware parsing

Made with my bare hands from pain & tears by Marc-Alexis-com
![](assets/brain-made.png)
