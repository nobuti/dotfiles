# load our own completion functions
fpath=(~/.zsh/completion $fpath)

# completion
# autoload -U compinit
# compinit
autoload -Uz compinit promptinit;
compinit
promptinit
prompt pure

for function in ~/.zsh/functions/*; do
  source $function
done

# automatically enter directories without cd
setopt auto_cd

# use sublime as the visual editor
export VISUAL=subl
export EDITOR=vim

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# use incremental search
bindkey "^R" history-incremental-search-backward

# add some readline keys back
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line

# expand functions in the prompt
setopt prompt_subst

# ignore duplicate history entries
setopt histignoredups

# keep TONS of history
export HISTSIZE=4096

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

export PATH="$HOME/.yarn/bin:$PATH"
source ~/.zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

eval "$(rbenv init -)"
. ~/.zsh/plugins/z/z.sh

# added by travis gem
[ -f /home/buti/.travis/travis.sh ] && source /home/buti/.travis/travis.sh
