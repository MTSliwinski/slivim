return {
  "numToStr/Comment.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
  config = function()
    require("Comment").setup()
    -- default keymaps: gcc (line), gc (visual/operator) are set up automatically
  end,
}
