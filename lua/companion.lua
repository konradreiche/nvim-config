require('copilot').setup()

require("copilot_cmp").setup()

require("CopilotChat").setup {
  model = 'gpt-4o',
  window = {
    layout = 'float',
  }
}

vim.keymap.set({ "n", "v" }, "<leader>c", ":CopilotChat<CR>", { desc = "Open Copilot Chat" })
