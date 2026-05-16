local map = vim.keymap.set

-- Clear search (replaces legacy <CR>:noh). Safe — no quickfix conflict.
map("n", "<Esc><Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- Buffers (preserve legacy bindings)
map("n", "<C-Left>",  "<cmd>bprev<CR>", { desc = "Prev buffer" })
map("n", "<C-Right>", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<C-x>",     "<cmd>bw<CR>",    { desc = "Wipe buffer" })
map("n", "<C-n>",     "<cmd>enew<CR>",  { desc = "New buffer" })
map("n", "<leader><leader>", "<C-^>",   { desc = "Alternate buffer" })

-- Windows
map("n", "<leader>w", "<C-w><C-w>", { desc = "Cycle window" })
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- Move lines (Alt-Up/Down, legacy)
map("n", "<A-Up>",   ":m-2<CR>==",         { desc = "Move line up" })
map("n", "<A-Down>", ":m+<CR>==",          { desc = "Move line down" })
map("i", "<A-Up>",   "<Esc>:m-2<CR>==gi",  { desc = "Move line up" })
map("i", "<A-Down>", "<Esc>:m+<CR>==gi",   { desc = "Move line down" })
map("v", "<A-Up>",   ":m '<-2<CR>gv=gv",   { desc = "Move selection up" })
map("v", "<A-Down>", ":m '>+1<CR>gv=gv",   { desc = "Move selection down" })

-- Terminal-friendly fallback (macOS Terminal may swallow Alt)
map("n", "<leader>k", ":m-2<CR>==",       { desc = "Move line up" })
map("n", "<leader>j", ":m+<CR>==",        { desc = "Move line down" })
map("v", "<leader>k", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
map("v", "<leader>j", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })

-- Search word under cursor (legacy)
map("n", "<leader>s", [[/\<<C-r><C-w>\>]],     { desc = "Search word under cursor" })
map("n", "<leader>r", [[:%s/\<<C-r><C-w>\>/]], { desc = "Replace word under cursor" })

-- Center after big jumps
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Save
map({ "n", "i" }, "<C-s>", "<Esc><cmd>w<CR>", { desc = "Save file" })

-- Better paste over selection (don't yank replaced text)
map("v", "p", '"_dP', { desc = "Paste without yanking" })

-- Toggle cursorline (legacy F7)
map("n", "<F7>", "<cmd>set cursorline!<CR>", { desc = "Toggle cursorline" })

-- Quick diagnostics nav (LSP)
map("n", "[g", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Prev diagnostic" })
map("n", "]g", function() vim.diagnostic.jump({ count = 1,  float = true }) end, { desc = "Next diagnostic" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics loclist" })
