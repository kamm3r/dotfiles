# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# vi mode
set -o vi

# History in cache directory
HISTSIZE=1000
HISTFILESIZE=1000
HISTFILE=~/.cache/bash/history

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Autocomplete??
bind "set show-all-if-ambiguous on"
bind "TAB:menu-complete"

# tmux configuation
alias tmc="tmux source ~/.config/tmux/.tmux.conf"
bind '"\C-f":"tmux-sessionizer\n"'


# Starship Prompt
eval "$(starship init bash)"

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# fnm
eval "$(fnm env --use-on-cd)"
