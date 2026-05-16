return {
  -- Formatter (replaces ALE fixers + vim-prettier)
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = {
      formatters_by_ft = {
        javascript     = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        typescript     = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        json           = { "prettierd", "prettier", stop_after_first = true },
        jsonc          = { "prettierd", "prettier", stop_after_first = true },
        html           = { "prettierd", "prettier", stop_after_first = true },
        css            = { "prettierd", "prettier", stop_after_first = true },
        scss           = { "prettierd", "prettier", stop_after_first = true },
        markdown       = { "prettierd", "prettier", stop_after_first = true },
        yaml           = { "prettierd", "prettier", stop_after_first = true },
        lua            = { "stylua" },
      },
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
        return { timeout_ms = 1500, lsp_fallback = true }
      end,
    },
    init = function()
      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then vim.b.disable_autoformat = true
        else vim.g.disable_autoformat = true end
      end, { desc = "Disable autoformat-on-save", bang = true })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, { desc = "Re-enable autoformat-on-save" })
    end,
  },

  -- Linter (replaces ALE lint; eslint LSP covers most JS, lint plugin handles edge cases)
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      local lint = require("lint")
      lint.linters_by_ft = {
        -- eslint via LSP already covers JS/TS — leave empty unless needed
        -- markdown = { "markdownlint" },
      }
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = vim.api.nvim_create_augroup("lint", { clear = true }),
        callback = function() require("lint").try_lint() end,
      })
    end,
  },

  -- Mason bridge for installing formatters/linters
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    event = "VeryLazy",
    opts = {
      ensure_installed = {
        "prettierd",
        "prettier",
        "stylua",
      },
      auto_update = false,
      run_on_start = true,
    },
  },
}
