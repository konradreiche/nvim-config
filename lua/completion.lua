local luasnip = require("luasnip")
local cmp = require("cmp")

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
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- Add LuaSnip as a source
    { name = 'buffer' },
    { name = 'path' },
  }),
  window = {
    completion = cmp.config.window.bordered(), -- Adds a border to the dropdown menu
    documentation = cmp.config.window.bordered({
      border = 'rounded',
      max_width = 80,
      max_height = 20,
      winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder",
    }),
  },
  formatting = {
    format = function(entry, vim_item)
      local item = entry.completion_item

      -- Delete Kind as it is not very interesting
      vim_item.kind = ''

      -- Add horizontal bar between signature and documentation if documentation exists
      if item.documentation and item.documentation.value ~= "" then
        item.documentation.value = "---" .. "\n\n" .. item.documentation.value
      end

      return vim_item
    end,
  },
})
