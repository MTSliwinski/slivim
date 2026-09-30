return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    -- cmd: lets :Mason/:MasonInstall load it before any file is opened (e.g. headless installs)
    { "mason-org/mason.nvim", cmd = { "Mason", "MasonInstall", "MasonUpdate" }, opts = {} },
    "mason-org/mason-lspconfig.nvim",
    "b0o/schemastore.nvim",
    "SmiteshP/nvim-navic",
  },
  config = function()
    -- Applied to every server enabled via vim.lsp.enable (mason-lspconfig does this)
    vim.lsp.config("*", {
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })

    vim.lsp.config("jsonls", {
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })

    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "jsonls", "pyright" },
      automatic_enable = true,
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("slivim_lsp_attach", { clear = true }),
      callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, bufnr)
        end

        local function map(lhs, rhs, desc, opts)
          vim.keymap.set("n", lhs, rhs, vim.tbl_extend("force", { buffer = bufnr, desc = desc }, opts or {}))
        end
        map("gd", vim.lsp.buf.definition, "Goto definition")
        -- nowait: don't wait on Neovim's default gra/gri/grn/grr mappings
        map("gr", vim.lsp.buf.references, "Goto references", { nowait = true })
        map("K", vim.lsp.buf.hover, "Hover docs")
        map("<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("<leader>rn", vim.lsp.buf.rename, "Rename symbol")
      end,
    })

    vim.diagnostic.config({
      virtual_text = true,
      signs = true,
      underline = true,
      update_in_insert = false,
    })
  end,
}
