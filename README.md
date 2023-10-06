# nvim-tabulous

Clean tabline for Neovim. Shows windows per tab with a separator.

<img width="1000" src="https://github.com/jryom/nvim-tabulous/assets/2834949/cc014bb1-b271-4576-a96d-6e1970b43106">


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
