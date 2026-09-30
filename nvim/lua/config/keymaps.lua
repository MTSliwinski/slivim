-- Keymaps: LunarVim-style defaults + user's custom keymaps ported from lvim/config.lua
local map = vim.keymap.set

-- ===== User's custom keymaps (from lvim/config.lua) =====
map("n", "|", "<cmd>vsplit<CR>", { desc = "Vertical split" })
map("n", "\\", "<cmd>split<CR>", { desc = "Horizontal split" })
map("n", "gt", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "gT", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })

-- ===== LunarVim-style default keymaps =====

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Buffer navigation (in addition to user's gt/gT)
map("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
map("n", "<leader>c", "<cmd>bdelete<CR>", { desc = "Close buffer" })

-- File explorer
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })

-- Diagnostics (LSP keymaps are buffer-local, set on LspAttach in lua/plugins/lsp.lua)
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Prev diagnostic" })
map("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })

-- Terminal (LunarVim default floating terminal toggle)
map("n", "<C-\\>", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })

-- Git (gitsigns hunk preview / navigation)
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview git hunk" })
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", { desc = "Git blame line" })

-- Formatting
map("n", "<leader>fm", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format buffer" })
