# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

# You may need to manually set your language environment
export LANG=en_US.UTF-8
export LC_CTYPE=en_IE.UTF-8
export LC_ALL=en_IE.UTF-8

# Other XDG paths
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_STATE_HOME=${XDG_STATE_HOME:="$HOME/.local/state"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_PICTURES_DIR=${XDG_PICTURES_DIR:="$HOME/picures"}
export HISTFILE="$XDG_STATE_HOME"/bash/history

# Disable files
export LESSHISTFILE=-
export DIFFPROG="nvim -d"

# Default Apps
export EDITOR="nvim"
export VISUAL="nvim"
export SUDO_EDITOR="nvim"
export READER="zathura"
export TERMINAL="alacritty"
export BROWSER="firefox"
export VIDEO="celluloid"
export IMAGE="loupe"
export COLORTERM="truecolor"

# Path
export PATH=$PATH:"$HOME/bin:$HOME/.local/bin:$HOME/go/bin:$HOME/.local/share/cargo/bin:$XDG_DATA_HOME/npm/bin"

export PKG_CONFIG_PATH=/path/to/xtst.pc:$PKG_CONFIG_PATH

# pnpm
export PNPM_HOME="/home/shush/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH=$BUN_INSTALL/bin:$PATH

# golang
export PATH=$PATH:/usr/local/go/bin

## SANE HISTORY DEFAULTS ##

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Re-edit the command line for failing history expansions
shopt -s histreedit

# Re-edit the result of history expansions
shopt -s histverify

# save history with newlines instead of ; where possible
shopt -s lithist

# vi mode
set -o vi

# History in cache directory:
export HISTSIZE=$((0x7FFF7FFF))
export HISTFILESIZE=$((0x7FFF7FFF))

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
HISTIGNORE="exit:ls:bg:fg:history:clear"

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

## SMARTER TAB-COMPLETION (Readline bindings) ##

# Conditionally perform file completion in a case insensitive fashion.
# Setting OMB_CASE_SENSITIVE to 'true' will switch from the default,
# case insensitive, matching to the case-sensitive one
#
# Note: CASE_SENSITIVE is the compatibility name
if [[ ${OMB_CASE_SENSITIVE:-${CASE_SENSITIVE:-}} == true ]]; then
	bind "set completion-ignore-case off"
else
	# By default, case sensitivity is disabled.
	bind "set completion-ignore-case on"

	# Treat hyphens and underscores as equivalent
	# CASE_SENSITIVE must be off
	if [[ ! ${OMB_HYPHEN_SENSITIVE-} && ${HYPHEN_INSENSITIVE} ]]; then
		case $HYPHEN_INSENSITIVE in
		(true)  OMB_HYPHEN_SENSITIVE=true ;;
		(false) OMB_HYPHEN_SENSITIVE=false ;;
		esac
	fi
	if [[ ${OMB_HYPHEN_SENSITIVE-} == false ]]; then
		bind "set completion-map-case on"
	fi
fi

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"
bind "TAB:menu-complete"

# tmux configuation
alias tmc="tmux source ~/.config/tmux/.tmux.conf"
bind '"\C-f":"tmux-sessionizer\n"'


# Starship Prompt
eval "$(starship init bash)"

# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# fnm
eval "$(fnm env --use-on-cd)"

# fzf shell integration
eval "$(fzf --bash)"

export GPG_TTY=$(tty)

. "$HOME/.cargo/env"
