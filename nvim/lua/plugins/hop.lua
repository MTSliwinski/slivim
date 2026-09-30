-- User's custom plugin from lvim/config.lua + lvim/plugin/keymaps.lua
return {
  "smoka7/hop.nvim", -- maintained fork of the archived phaazon/hop.nvim
  version = "*",
  event = "VeryLazy",
  config = function()
    local hop = require("hop")
    hop.setup()

    local directions = require("hop.hint").HintDirection
    vim.keymap.set("", "f", function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false })
    end)
    vim.keymap.set("", "F", function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false })
    end)
    vim.keymap.set("", "t", function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = false, hint_offset = -1 })
    end)
    vim.keymap.set("", "T", function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = false, hint_offset = 1 })
    end)
    vim.keymap.set("", "s", function()
      hop.hint_char1({ current_line_only = false })
    end)
  end,
}
