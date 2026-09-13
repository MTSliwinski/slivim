-- Keymaps: LunarVim-style defaults + user's custom keymaps ported from lvim/config.lua
local map = vim.keymap.set

-- ===== User's custom keymaps (from lvim/config.lua) =====
map("n", "|", ":vsplit<CR>", { desc = "Vertical split" })
map("n", "\\", ":split<CR>", { desc = "Horizontal split" })
map("n", "gt", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "gT", ":BufferLineCyclePrev<CR>", { desc = "Prev buffer" })

-- ===== LunarVim-style default keymaps =====

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Buffer navigation (in addition to user's gt/gT)
map("n", "<S-l>", ":BufferLineCycleNext<CR>", { desc = "Next buffer" })
map("n", "<S-h>", ":BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
map("n", "<leader>c", ":bdelete<CR>", { desc = "Close buffer" })

-- File explorer
map("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
map("n", "<leader>fw", "<cmd>Telescope live_grep<CR>", { desc = "Live grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Find buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Recent files" })

-- LSP (attached globally; harmless if no LSP client active)
map("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "Goto references" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover docs" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>ld", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- Terminal (LunarVim default floating terminal toggle)
map("n", "<C-\\>", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })

-- Git (gitsigns hunk preview / navigation)
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", { desc = "Preview git hunk" })
map("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", { desc = "Git blame line" })

-- Formatting
map("n", "<leader>fm", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format buffer" })
