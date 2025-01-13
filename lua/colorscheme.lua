local light = "#ebdbb2"
local red = "#fb4934"
local green = "#b8bb26"
local yellow = "#fabd2f"
local blue = "#83a598"
local purple = "#d3869b"
local aqua = "#8ec07c"
local orange = "#fe8019"

require("gruvbox").setup({
  terminal_colors = true, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = false,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "hard", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
  overrides = {
    ["@function.method"] = { fg = white },
    ["@struct"] = { fg = blue },
    ["@interface"] = { fg = blue },
    Identifier = { fg = light },
    ["@constant.builtin"] = { fg = purple },
    ["@function.builtin"] = { fg = blue },
    Function = { fg = white },
    ["@type.go"] = { fg = white },
    ["@property.type"] = { fg = yellow },
    ["@type.definition.go"] = { fg = white },
    ["@constructor.go"] = { fg = white },
    ["@type.parameter"] = { fg = yellow },
    Delimiter = { fg = light },
  }
})

vim.cmd("colorscheme gruvbox")
