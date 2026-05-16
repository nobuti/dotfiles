-- nvim-treesitter "main" branch (master is archived).
-- New API: no setup() — manual install + enable via autocmd.
return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local nts = require("nvim-treesitter")

      local parsers = {
        "javascript", "typescript", "tsx", "jsdoc",
        "html", "css", "scss", "json",
        "lua", "vim", "vimdoc", "query",
        "bash", "markdown", "markdown_inline",
        "yaml", "toml", "regex",
        "gitcommit", "gitignore", "diff",
      }

      -- Install missing parsers (async; non-blocking).
      nts.install(parsers)

      -- Map parser → filetypes that should activate it.
      local ft_map = {
        javascript      = { "javascript", "javascriptreact" },
        typescript      = { "typescript" },
        tsx             = { "typescriptreact" },
        bash            = { "sh", "bash", "zsh" },
        markdown        = { "markdown" },
        markdown_inline = { "markdown" },
        json            = { "json", "jsonc" },
      }

      local ft_list = {}
      for _, p in ipairs(parsers) do
        local fts = ft_map[p] or { p }
        for _, ft in ipairs(fts) do
          ft_list[ft] = true
        end
      end
      local fts = {}
      for ft in pairs(ft_list) do table.insert(fts, ft) end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("ts_start", { clear = true }),
        pattern = fts,
        callback = function(args)
          -- Highlight (silent if parser missing).
          pcall(vim.treesitter.start, args.buf)
          -- Indent powered by treesitter.
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },

  -- Autotag (HTML/JSX). Standalone — no longer depends on treesitter plugin.
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    opts = {},
  },
}
