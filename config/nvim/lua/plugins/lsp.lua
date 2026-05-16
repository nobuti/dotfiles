return {
  -- Mason: install LSP/formatter/linter binaries
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = { border = "rounded" },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "ts_ls",
        "eslint",
        "html",
        "cssls",
        "tailwindcss",
        "jsonls",
      },
      automatic_enable = true,
    },
  },

  -- LSP base: configures servers via nvim 0.11+ API
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Diagnostic UI
      vim.diagnostic.config({
        virtual_text = { prefix = "●", spacing = 4 },
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "✘",
            [vim.diagnostic.severity.WARN]  = "▲",
            [vim.diagnostic.severity.HINT]  = "⚑",
            [vim.diagnostic.severity.INFO]  = "»",
          },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
      })

      -- LSP attach: keymaps per-buffer
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp_attach", { clear = true }),
        callback = function(args)
          local bufnr = args.buf
          local function nmap(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
          end
          nmap("gd", vim.lsp.buf.definition,      "Go to definition")
          nmap("gD", vim.lsp.buf.declaration,     "Go to declaration")
          nmap("gy", vim.lsp.buf.type_definition, "Type definition")
          nmap("gi", vim.lsp.buf.implementation,  "Go to implementation")
          nmap("gr", vim.lsp.buf.references,      "References")
          nmap("K",  vim.lsp.buf.hover,           "Hover")
          nmap("<leader>rn", vim.lsp.buf.rename,         "Rename symbol")
          nmap("<leader>ca", vim.lsp.buf.code_action,    "Code action")
          nmap("<leader>fm", function() vim.lsp.buf.format({ async = true }) end, "Format")
        end,
      })

      -- Global defaults for all servers
      vim.lsp.config("*", { capabilities = capabilities })

      -- Per-server overrides (optional — defaults are fine for these)
      -- vim.lsp.config("ts_ls", { settings = {} })
      -- vim.lsp.config("eslint", { settings = {} })

      -- mason-lspconfig with automatic_enable = true auto-calls
      -- vim.lsp.enable() for installed servers.
    end,
  },
}
