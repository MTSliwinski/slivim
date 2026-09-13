-- General editor options (mirrors LunarVim's defaults)
local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.wrap = false

opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true

opt.splitbelow = true
opt.splitright = true

opt.termguicolors = true
opt.scrolloff = 5
opt.swapfile = false
opt.backup = false
opt.undofile = true

opt.updatetime = 300
opt.timeoutlen = 500
opt.clipboard = "unnamedplus"
opt.completeopt = { "menu", "menuone", "noselect" }

vim.g.mapleader = " "
vim.g.maplocalleader = " "
