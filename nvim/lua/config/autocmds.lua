-- Autocmds ported from lvim/plugin/keymaps.lua

-- Terminal-mode keymap: exit terminal insert mode with <C-n>
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<C-n>", [[<C-\><C-n>]], opts)
  -- vim.keymap.set('t', '<ESC>', [[<C-\><C-n>]], opts)
end

vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*",
  callback = function()
    set_terminal_keymaps()
  end,
})
