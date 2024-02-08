if [ -f ~/.bashrc ]; then
    source ~/.bashrc;
fi

# hide default interactivelty message
export BASH_SILENCE_DEPRECATION_WARNING=1

# Other XDG paths
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}
export XDG_PICTURE_DIR=${XDG_PICTURE_DIR:="$HOME/picture"}
export HISTFILE="$XDG_DATA_HOME"/bash/history

# Disable files
export LESSHISTFILE=-
export DIFFPROG="nvim -d"

# Default apps
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export COLORTERM="truecolor"

# Path
export PATH="$PATH":"$HOME/.local/scripts/"
export PATH="$PATH":"$XDG_DATA_HOME/npm/bin"
