# nvim-tabulous

Clean tabline for Neovim. Shows windows per tab with a separator.

<img width="1804" alt="Screenshot 2023-10-06 at 11 02 43" src="https://github.com/jryom/nvim-tabulous/assets/2834949/e79f56de-79b8-4871-b97c-d688d7a27021">

## Installation

With `lazy.nvim`:

```lua
{
    'jryom/nvim-tabulous',
    opts = {
    --  Default options:
    --  show_index = true,
    --  fnamemodify = ":t",
    --  modified_string = " +",
    --  max_windows = 3, -- Max windows shown per tab
    --  auto_hide = true, -- Hide when only one tab
    --  separator = "▕",
    --  window_separator = " | ",
    --  padding = "   ", -- Horizontal padding in each tab
    --  ignored_buftypes = { "nofile" },
    },
}
```
