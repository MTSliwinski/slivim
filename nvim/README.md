# Neovim config (migrated from LunarVim)

This is a standalone Neovim config that replaces `lvim/` (LunarVim). It uses
`lazy.nvim` as the plugin manager and recreates LunarVim's default plugins/keymaps
plus your custom additions from `lvim/config.lua` and `lvim/plugin/keymaps.lua`.

**Requires Neovim 0.11+** (uses `vim.lsp.config` and current plugin APIs).

## Installing

```sh
# back up any existing config first
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null
mv ~/.local/share/nvim ~/.local/share/nvim.bak 2>/dev/null

# symlink (or copy) this folder into place
ln -s ~/workspace/slivim/nvim ~/.config/nvim

nvim
# lazy.nvim will bootstrap itself and install all plugins on first launch
```

Plugin versions are pinned in `lazy-lock.json`; use `:Lazy restore` to match it
exactly, or `:Lazy sync` to update (then commit the new lock file).

`lua_ls`, `jsonls` and `pyright` are installed automatically by mason-lspconfig;
run `:Mason` to add more LSP servers/formatters. Installed servers are enabled
automatically. Add formatters/linters to `lua/plugins/null-ls.lua`.

## What was carried over from `lvim/`

- Custom plugin: `hop.nvim` (`lua/plugins/hop.lua`, now the maintained `smoka7/hop.nvim` fork) with the same `f F t T s` motions
  and the terminal `<C-n>` exit-terminal-mode mapping (`lua/config/autocmds.lua`).
- Custom keymaps: `| \ gt gT` (`lua/config/keymaps.lua`).

## What was recreated from LunarVim defaults

- Leader key: `<space>`
- `<leader>e` toggle file explorer (nvim-tree)
- `<leader>ff/fw/fb/fh/fo` telescope find files / grep / buffers / help / recent
- `<C-h/j/k/l>` window navigation, `<S-h>/<S-l>` buffer navigation, `<leader>c` close buffer
- `gd gr K <leader>ca <leader>rn` LSP keymaps (buffer-local, set when a server attaches)
- `<leader>ld [d ]d` diagnostics
- `gcc`/`gc` comment toggle (Comment.nvim default)
- `<C-\>` floating terminal (toggleterm)
- `<leader>gp <leader>gb` gitsigns hunk preview/blame
- `<leader>db <leader>dc <leader>do <leader>di <leader>du` DAP keymaps

## Notes / things to check manually

- `lir.nvim`, `lunar.nvim`, `structlog.nvim`, `nlsp-settings.nvim`, `bigfile.nvim`
  were LunarVim-internal plugins and are **not** included; nvim-tree covers file
  browsing.
- `null-ls.nvim` is archived upstream; replaced with its maintained fork
  `nvimtools/none-ls.nvim` (same API, `require("null-ls")`).
- `neodev.nvim` is replaced by `folke/lazydev.nvim`.
- `nvim-treesitter` is pinned to its `master` branch; the new `main` branch is an
  incompatible rewrite.
