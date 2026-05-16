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
  ast-grep colima difftastic docker docker-compose fd fzf gh git helix just \
  mole nvm pnpm ripgrep rtk shellcheck starship yq z \
  zsh-autosuggestions zsh-syntax-highlighting
```

### Package reference

**Editor**
- `helix` — post-modern modal editor (config in `~/.config/helix/`). Aliased as `vim`, `vi`, `nvim` and set as `$EDITOR`

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

## Helix

Modal editor written in Rust. Tree-sitter, LSP, file-watching, and multi-cursor all built-in — no plugin system. Config lives in `~/.config/helix/`.

### Files

```
~/.config/helix/
├── config.toml       # editor options + keybindings
├── languages.toml    # LSP/formatter wiring per language
└── themes/           # optional custom themes
```

### Language servers

Install the JS/TS stack globally via pnpm:

```sh
pnpm add -g typescript typescript-language-server vscode-langservers-extracted \
            @tailwindcss/language-server prettier
```

Verify with `hx --health <language>` (e.g. `hx --health typescript`).

### Daily commands

```sh
hx                # open
hx --tutor        # interactive tutorial (~30 min, mandatory if coming from vim)
hx --health       # global status of LSPs, formatters, parsers
:config-reload    # reload config without restart
```

### Legacy Vim

`~/.vimrc` is left untouched for classic Vim. Helix ignores it.
