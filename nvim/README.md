# Neovim config (migrated from LunarVim)

This is a standalone Neovim config that replaces `lvim/` (LunarVim). It uses
`lazy.nvim` as the plugin manager and recreates LunarVim's default plugins/keymaps
plus your custom additions from `lvim/config.lua` and `lvim/plugin/keymaps.lua`.

## Installing

```sh
# back up any existing config first
mv ~/.config/nvim ~/.config/nvim.bak 2>/dev/null
mv ~/.local/share/nvim ~/.local/share/nvim.bak 2>/dev/null

# symlink (or copy) this folder into place
ln -s /Users/marcinsliwinski/workspace/vim-config/nvim ~/.config/nvim

nvim
# lazy.nvim will bootstrap itself and install all plugins on first launch
```

After plugins install, run `:Mason` to install any LSP servers/formatters you need
(mason-lspconfig auto-installs servers for filetypes you open, but you can also
install manually). Add formatters/linters to `lua/plugins/null-ls.lua`.

## What was carried over from `lvim/`

- Custom plugin: `hop.nvim` (`lua/plugins/hop.lua`) with the same `f F t T s` motions
  and the terminal `<C-n>` exit-terminal-mode mapping (`lua/config/autocmds.lua`).
- Custom keymaps: `| \ gt gT` (`lua/config/keymaps.lua`).

## What was recreated from LunarVim defaults

- Leader key: `<space>`
- `<leader>e` toggle file explorer (nvim-tree)
- `<leader>ff/fw/fb/fh/fo` telescope find files / grep / buffers / help / recent
- `<C-h/j/k/l>` window navigation, `<S-h>/<S-l>` buffer navigation, `<leader>c` close buffer
- `gd gr K <leader>ca <leader>rn <leader>ld [d ]d` LSP keymaps
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
- `lazy-lock.json` was carried over from the old lock file for reference only;
  it will be rewritten by `lazy.nvim` after the first `:Lazy sync`/install since
  the plugin set changed slightly.
- `mason-lspconfig.ensure_installed` is empty — install servers per-project via
  `:Mason` or add them there.
- Not tested — please open `nvim` and debug/tweak as needed.
