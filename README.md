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

Add taps:

```sh
brew tap stripe/stripe-cli
```

Install everything:

```sh
brew install \
  ast-grep colima difftastic docker docker-compose fd fzf gh git just \
  mole neovim nvm pnpm ripgrep rtk shellcheck starship stripe yq z \
  zsh-autosuggestions zsh-syntax-highlighting
```

### Package reference

**Editor**
- `neovim` — modern Vim fork (config in `config/nvim/`)

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
- `stripe` — Stripe CLI (`stripe/stripe-cli` tap)
- `rtk` — CLI proxy to minimize LLM token consumption
- `mole` — macOS deep clean & optimization

## Neovim

Plugin manager is `vim-plug`. On first launch run `:PlugInstall`. See `vimrc` for plugin list and `config/nvim/init.vim` for the entry point.

Optional dependencies for full IDE features:

```sh
nvm install --lts             # required by coc.nvim
nvm use --lts
nvim +'CocInstall coc-tsserver coc-json coc-eslint coc-prettier' +qa
```
