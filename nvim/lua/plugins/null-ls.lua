return {
  "nvimtools/none-ls.nvim", -- community-maintained continuation of null-ls.nvim
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- add formatters/linters here, e.g.:
        -- null_ls.builtins.formatting.stylua,
        -- null_ls.builtins.diagnostics.eslint,
      },
    })
  end,
}
