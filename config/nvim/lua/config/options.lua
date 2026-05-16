local opt = vim.opt

-- UI
opt.termguicolors = true
opt.number = true
opt.relativenumber = false
opt.cursorline = false
opt.signcolumn = "yes"
opt.showmode = false
opt.showcmd = true
opt.ruler = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.linebreak = true
opt.showbreak = "+++ "
opt.list = true
opt.listchars = { tab = "→ ", trail = "·", nbsp = "␣", extends = "›", precedes = "‹" }

-- Search
opt.hlsearch = true
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.inccommand = "split"

-- Indent
opt.expandtab = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2
opt.autoindent = true
opt.smartindent = true
opt.smarttab = true

-- Editing
opt.backspace = { "indent", "eol", "start" }
opt.textwidth = 100
opt.showmatch = true

-- Windows
opt.splitright = true
opt.splitbelow = true

-- Files
opt.backup = false
opt.swapfile = false
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"
opt.undolevels = 1000
opt.confirm = true
opt.updatetime = 100
opt.timeoutlen = 400

-- Clipboard / mouse
opt.clipboard = "unnamedplus"
opt.mouse = "a"

-- Completion
opt.completeopt = { "menu", "menuone", "noselect" }
opt.pumheight = 12

-- Wild
opt.wildmenu = true
opt.wildignore:append({ "*/node_modules/*", "*/.git/*", "*/dist/*", "*/build/*" })

-- Misc
opt.visualbell = true
opt.shortmess:append("I") -- skip intro
opt.fillchars = { eob = " " }
