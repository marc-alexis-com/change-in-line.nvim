# change-in-line.nvim
Neovim plugin that turns `ci"` / `ca"` into smart operations on the current line.

## Features
- `ci"` and `ca"` automatically find the closest double quote pair on the current line
- Ignores escaped double quotes (`\"`)

## Limitations (V1)
- Only supports double quotes `"`
- In case of distance equality between 2 pairs, selects the left one
- Lines mixing escaped `\"` and regular `"` may produce unexpected results

## Installation
```lua
{
    "marc-alexis-com/change-in-line.nvim",
    config = fuction()
        require("change-in-line").setup()
    end,
}
```

## Roadmap to V2
- [ ] Explicit label mode to choose between multiple pairs
- [ ] Support other pairs: `'`, `(`, `{`, `[`...
- [ ] Use treesitter to distinguish between edge cases (i.e. \', then a single ', then 'word')
