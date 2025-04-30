-- organize imports
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.format()
    vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
  end
})

vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = '*.go',
  callback = function()
    local tool = vim.fn.getenv("GO_EXTRA_FMT")
    if type(tool) == "string" and tool ~= "" then
      local file_path = vim.fn.expand('%:p')
      local cmd = vim.fn.split(tool, " ")
      table.insert(cmd, file_path)

      if vim.fn.executable(cmd[1]) == 1 then
        vim.fn.system(cmd)
        vim.api.nvim_buf_call(0, function()
          vim.cmd('checktime')
        end)
      else
        vim.notify("Executable not found: " .. cmd[1], vim.log.levels.WARN)
      end
    end
  end,
})
