return {
  "numToStr/Comment.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  config = function()
    vim.g.skip_ts_context_commentstring_module = true
    require("ts_context_commentstring").setup({ enable_autocmd = false })
    -- default keymaps: gcc (line), gc (visual/operator) are set up automatically
    require("Comment").setup({
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    })
  end,
}
