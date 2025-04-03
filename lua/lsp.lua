-- configure nvim-lspcofnig
lspconfig = require "lspconfig"
util = require "lspconfig/util"

local on_attach = function(client, bufnr)
  -- Clear format program (gofmt) to ensure gq still breaks lines
  vim.opt.formatprg = ""

  -- Key mappings for LSP functionality (optional)
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)

  -- Jump to the next diagnostic
  vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_next, { noremap = true, silent = true })

  -- Jump to the previous diagnostic
  vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_prev, { noremap = true, silent = true })
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()

lspconfig.gopls.setup {
  cmd = {"gopls", "serve"},
  filetypes = {"go", "gomod"},
  root_dir = util.root_pattern("go.work", "go.mod", ".git"),
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    gopls = {
      staticcheck = true,
      usePlaceholders = true,
      completeUnimported = true,
    },
  },
  workspace = {
    didChangeWatchedFiles = {
      dynamicRegistration = true,
    },
  },
}
