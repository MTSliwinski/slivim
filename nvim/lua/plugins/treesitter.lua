return {
  "nvim-treesitter/nvim-treesitter",
  branch = "master", -- `main` is an incompatible rewrite without nvim-treesitter.configs
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSUpdate", "TSUpdateSync" },
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "lua", "vim", "vimdoc", "bash", "json", "markdown", "python" },
      -- install synchronously when headless (e.g. Docker build) so nvim doesn't exit mid-install
      sync_install = #vim.api.nvim_list_uis() == 0,
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })
  end,
}
