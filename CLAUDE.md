# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A personal Neovim configuration (`nvim/`, Lua, `lazy.nvim`, **requires Neovim 0.11+**) migrated from LunarVim, plus a Docker demo environment for trying it out. There is no build system, test suite, or linter — "testing" means launching Neovim with the config. Verify changes by actually loading them.

## Commands

```sh
# Run the config in an isolated Ubuntu 24.04 container (builds image, then opens nvim)
./run-demo.sh

# Isolated headless smoke test (config from ./nvim, plugins/state in a throwaway dir)
export XDG_CONFIG_HOME=$PWD XDG_DATA_HOME=/tmp/slivim/data XDG_STATE_HOME=/tmp/slivim/state XDG_CACHE_HOME=/tmp/slivim/cache
nvim --headless "+Lazy! sync" +qa          # install/update plugins, rewrites nvim/lazy-lock.json
nvim --headless some.py "+sleep 3" "+lua print(vim.inspect(vim.tbl_map(function(c) return c.name end, vim.lsp.get_clients())))" "+messages" +qa!
```

Headless `nvim` exits 0 even when a command errors, so read the output rather than trusting the exit code. The Dockerfile installs a pinned Neovim release (`NVIM_VERSION`), then runs `Lazy! restore` (lockfile commits), `TSUpdateSync` and `MasonInstall` at build time. Commit `nvim/lazy-lock.json` whenever plugins are added or updated, since Docker installs exactly what it pins.

## Architecture

- `nvim/init.lua` loads, in order: `config.options` (sets `mapleader` — must run before lazy), `config.lazy` (bootstraps lazy.nvim and imports every file in `lua/plugins/`), `config.keymaps`, `config.autocmds`.
- `lua/plugins/*.lua`: one file per plugin, each returning a single lazy.nvim spec. New plugins are picked up automatically just by adding a file here. Most specs are lazy-loaded via `event`/`cmd`; only the colorscheme (tokyonight) is `lazy = false`.
- **Global keymaps are centralized in `lua/config/keymaps.lua`**, not in plugin specs, and invoke plugins via `<cmd>Command<CR>` strings (e.g. `NvimTreeToggle`, `Telescope …`) so they trigger `cmd`-based lazy loading. Exceptions: `hop.lua` sets its own `f F t T s` motions, `dap.lua` uses lazy `keys`, and LSP maps live in `lsp.lua`. which-key group names are registered in `which-key.lua`. Terminal-mode `<C-n>` lives in `autocmds.lua` (TermOpen).
- LSP (`lsp.lua`) uses Neovim's native `vim.lsp.config`: shared settings go in `vim.lsp.config("*", …)`, per-server settings in `vim.lsp.config("<server>", …)`; mason-lspconfig v2 installs `ensure_installed` servers and enables every installed server (`automatic_enable`). LSP keymaps and nvim-navic are set up buffer-locally in an `LspAttach` autocmd there, not in keymaps.lua. Lua API types come from `lazydev.lua`.
- `mason.nvim` and `nvim-treesitter` also declare `cmd` triggers so `:MasonInstall` / `:TSUpdateSync` work headlessly before any file is opened; treesitter is pinned to the `master` branch (`main` is an incompatible rewrite without `nvim-treesitter.configs`).
- Formatters/linters go in `null-ls.lua`, which uses `nvimtools/none-ls.nvim` (maintained fork, still `require("null-ls")`). Its source list is currently empty.

## Notes

- Comments referencing `lvim/config.lua` / `lvim/plugin/keymaps.lua` point to the original LunarVim config, which has been deleted from the repo; the listed keymaps in `nvim/README.md` are the reference for what must be preserved.
