# Dotfiles

## Requirements

Set zsh as your login shell:

```sh
chsh -s /bin/zsh
```

## Install

First, create symlinks for ssh credentials (usually backed up in Dropbox). Remove any existing `.zshrc` or `.bin` folder. Pay attention to possible changes or additions.

```sh
cd dotfiles
./install.sh
```

This creates symlinks for config files in your home directory.

## Homebrew packages

Install Homebrew first: https://brew.sh

Install everything:

```sh
brew install \
  ast-grep colima difftastic docker docker-compose fd fzf gh git just \
  mole neovim nvm pnpm ripgrep rtk shellcheck starship tree-sitter-cli yq z \
  zsh-autosuggestions zsh-syntax-highlighting
```

### Package reference

**Editor**
- `neovim` — modern Vim fork (config in `config/nvim/`)
- `tree-sitter-cli` — required by `nvim-treesitter` (main branch) to compile parsers

**Shell experience**
- `starship` — cross-shell prompt
- `zsh-autosuggestions` — inline command suggestions
- `zsh-syntax-highlighting` — syntax highlighting for zsh
- `z` — jump to frequently-visited directories

**Search & navigation**
- `fzf` — fuzzy finder
- `ripgrep` — fast recursive grep (`rg`)
- `fd` — fast user-friendly `find` alternative
- `ast-grep` — structural code search by AST
- `yq` — YAML/JSON/XML processor

**Git**
- `git` — version control
- `gh` — GitHub CLI
- `difftastic` — structural diff tool

**Containers**
- `colima` — Docker runtime on macOS (lighter than Docker Desktop)
- `docker` — Docker CLI
- `docker-compose` — multi-container orchestration

**JavaScript runtime**
- `nvm` — Node.js version manager
- `pnpm` — fast disk-efficient npm alternative

**Task runners & linters**
- `just` — command runner (Makefile alternative)
- `shellcheck` — shell script linter

**Other tools**
- `rtk` — CLI proxy to minimize LLM token consumption
- `mole` — macOS deep clean & optimization

## Neovim

Modern Lua config. Entry point: `config/nvim/init.lua`. Plugin manager is `lazy.nvim` (auto-bootstraps on first run). LSP via native `vim.lsp.config` + `mason.nvim`. Syntax via `nvim-treesitter` (main branch).

### Structure

```
config/nvim/
├── init.lua                  # entry point
├── lazy-lock.json            # plugin versions
└── lua/
    ├── config/               # options, keymaps, autocmds, lazy bootstrap
    └── plugins/              # one file per plugin group
        ├── colorscheme.lua   # tokyonight
        ├── lsp.lua           # mason + lspconfig + diagnostics
        ├── completion.lua    # nvim-cmp + LuaSnip
        ├── treesitter.lua    # parsers + highlight + indent
        ├── telescope/editor  # editor.lua: telescope, gitsigns, oil, comment, autopairs, surround, flash, todos
        ├── ui.lua            # lualine, bufferline, indent-blankline, which-key, notify
        ├── formatting.lua    # conform.nvim + nvim-lint
        └── git.lua           # fugitive
```

### First launch

```sh
nvim
```

- `lazy.nvim` clones itself and installs plugins.
- `mason.nvim` installs LSPs (`ts_ls`, `eslint`, `html`, `cssls`, `tailwindcss`, `jsonls`) and formatters (`prettierd`, `prettier`, `stylua`).
- `nvim-treesitter` installs parsers via `tree-sitter-cli`. Make sure it is on `$PATH` (`brew install tree-sitter-cli`).

Run `:checkhealth` to verify everything.

### Legacy Vim

`~/.vimrc` is preserved for classic Vim compatibility. Neovim ignores it — it loads `init.lua` instead.
