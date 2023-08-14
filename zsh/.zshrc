# Set up the prompt

autoload -U colors && colors # Load colors
setopt autocd
export EDITOR='nvim'
export TERMINAL='alacritty'
export BROWSER='firefox'
export TERM='xterm-256color'

# Keep 10000000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE=~/.cache/zsh/history

# Use modern completion system
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'
zmodload zsh/complist
_comp_options+=(globdots)

eval "$(dircolors -b)"

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

#Plugins
source ~/.config/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# tmux Configuration
alias tmc="tmux source ~/.config/tmux/.tmux.conf"
bindkey -s ^f "tmux-sessionizer\n"

# WSL
# export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0 # in WSL 2
# export LIBGL_ALWAYS_INDIRECT=1

# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

#Starship Configuration
eval "$(starship init zsh)"

# fnm
export PATH="/home/bobross/.fnm:$PATH"
eval "$(fnm env --use-on-cd)"

# rust
source "$HOME/.cargo/env"


# nvim switcher

alias nvim-kick="NVIM_APPNAME=kick nvim"
alias nvim-kicks="NVIM_APPNAME=kickstarter nvim"

function nvims() {
    items=("default" "kickstart")
    config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
    if [[ -z $config ]]; then
        echo "Nothing selected"
        return 0
    elif [[ $config == "default" ]]; then
        config=""
    fi
    NVIM_APPNAME=$config nvim $@
}


bindkey -s ^a "nvims\n"
