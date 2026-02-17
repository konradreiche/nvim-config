local luasnip = require("luasnip")
local cmp = require("cmp")

vim.api.nvim_set_hl(0, "CmpPmenu", { bg = "#282828", fg = "#ebdbb2" })
vim.api.nvim_set_hl(0, "CmpPmenuBorder", { bg = "#282828", fg = "#ebdbb2" })
vim.api.nvim_set_hl(0, "CmpPmenuSel", { bg = "#3c3836", fg = "#ebdbb2" })

local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
  Copilot = "",
}

-- nvim-cmp setup
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For LuaSnip users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<C-l>'] = cmp.mapping(function()
      if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      end
    end, { "i", "s" }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept current selection
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'luasnip', priority = 100 },
    { name = 'nvim_lsp', priority = 50 },
    { name = 'buffer', priority = 25 },
    { name = 'path', priority = 10 },
  }),
  window = {
    completion = cmp.config.window.bordered({
      border = { " ", " ", " ", " ", " ", " ", " ", " " },
      winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:CmpPmenuSel,Search:None'
    }),
    documentation = cmp.config.window.bordered({
      border = { " ", " ", " ", " ", " ", " ", " ", " " },
      winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:CmpPmenuSel,Search:None'
    }),
  },
  formatting = {
    format = function(entry, vim_item)
      local item = entry.completion_item

      -- Use a custom mapping to display icons instead of text
      vim_item.kind = kind_icons[vim_item.kind] or vim_item.kind

      -- Add horizontal bar between signature and documentation if documentation exists
      if item.documentation and item.documentation.value ~= "" then
        item.documentation.value = "---" .. "\n\n" .. item.documentation.value
      end

      return vim_item
    end,
  },
})
