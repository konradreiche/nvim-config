function count_errors()
  local diagnostics = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  return #diagnostics
end

vim.o.statusline = "%f %m %= %{v:lua.count_errors()} Errors"
