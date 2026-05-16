local au = vim.api.nvim_create_autocmd
local grp = vim.api.nvim_create_augroup

-- Highlight on yank
au("TextYankPost", {
  group = grp("highlight_yank", { clear = true }),
  callback = function() (vim.hl or vim.highlight).on_yank({ timeout = 150 }) end,
})

-- Trim trailing whitespace on save
au("BufWritePre", {
  group = grp("trim_whitespace", { clear = true }),
  pattern = "*",
  callback = function()
    local save = vim.fn.winsaveview()
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.winrestview(save)
  end,
})

-- Restore cursor position
au("BufReadPost", {
  group = grp("restore_cursor", { clear = true }),
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local lcount = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Close help/qf with q
au("FileType", {
  group = grp("close_with_q", { clear = true }),
  pattern = { "help", "qf", "lspinfo", "checkhealth", "man", "notify" },
  callback = function(args)
    vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = args.buf, silent = true })
  end,
})

-- 2-space indent for web stack
au("FileType", {
  group = grp("web_indent", { clear = true }),
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact",
              "json", "jsonc", "html", "css", "scss", "yaml", "lua" },
  callback = function()
    vim.bo.shiftwidth = 2
    vim.bo.softtabstop = 2
    vim.bo.expandtab = true
  end,
})
