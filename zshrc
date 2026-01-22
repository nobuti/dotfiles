for function in ~/.zsh/functions/*; do
  source $function
done

# automatically enter directories without cd
setopt auto_cd

# use sublime as the visual editor
export VISUAL=code
export EDITOR=vim

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# fzf - fuzzy finder integration (ctrl+r for history, ctrl+t for files)
# Install fzf with: brew install fzf
[ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ] && source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
[ -f /opt/homebrew/opt/fzf/shell/completion.zsh ] && source /opt/homebrew/opt/fzf/shell/completion.zsh

# Fallback to basic history search if fzf is not installed
if ! type fzf &>/dev/null; then
  bindkey "^R" history-incremental-search-backward
fi

# add some readline keys back
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# expand functions in the prompt
setopt prompt_subst

# ignore duplicate history entries
setopt histignoredups

# keep TONS of history
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
setopt SHARE_HISTORY          # share history across terminals
setopt APPEND_HISTORY         # append to history file

# automatically pushd
setopt auto_pushd
export dirstacksize=5

# awesome cd movements from zshkit
setopt AUTOCD
setopt AUTOPUSHD PUSHDMINUS PUSHDSILENT PUSHDTOHOME
setopt cdablevars

# Try to correct command line spelling
setopt CORRECT CORRECT_ALL

# Enable extended globbing
setopt EXTENDED_GLOB

# Git completion
autoload -Uz compinit && compinit
zmodload -i zsh/complist

export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Starship prompt
eval "$(starship init zsh)"

# z plugin
source /opt/homebrew/etc/profile.d/z.sh

# zsh-syntax-highlighting
# brew install zsh-syntax-highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-autosuggestions
# brew install zsh-autosuggestions
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=250'
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# This tells Zsh to keep the PATH array unique
typeset -U path

# Add your personal bin folders to the FRONT of the path
path=("$HOME/.local/bin" "$HOME/bin" "$HOME/.bin" $path)
export PATH

# Assuming this is inside your .zshrc
DOTFILES_PATH="$HOME/Dev/dotfiles"
[ -f "$DOTFILES_PATH/zsh/env/env.local" ] && source "$DOTFILES_PATH/zsh/env/env.local"
