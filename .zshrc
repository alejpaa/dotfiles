#
if [ -f /usr/bin/fastfetch ]; then
	fastfetch
fi

setopt autocd

# jumping y delete words
# -- nice word jumping and deleting

autoload -U select-word-style
select-word-style bash
export WORDCHARS=''
bindkey "^[[1;5C" forward-word # ctrl + right
bindkey "^[[1;5D" backward-word # ctrl + left
bindkey "^H" backward-delete-word # ctrl + backspace
bindkey '^[[3;5~' delete-word # ctrl + delete


# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME=""


# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(git zsh-autosuggestions fast-syntax-highlighting fzf-tab)

source $ZSH/oh-my-zsh.sh

# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH=$PATH:/usr/local/go/bin

export PATH="$PATH:$HOME/go/bin"
export PATH="$PATH:/home/alem/.scripts"

# alias
alias zed='flatpak run dev.zed.Zed'
alias dots='/usr/bin/git --work-tree=$HOME --git-dir=$HOME/.dotfiles'
alias rm='trash -v'
alias vi='nvim'
alias svi='sudo vi'

# Remove a directory and all files
alias rmd='/bin/rm  --recursive --force --verbose '

# Check if ripgrep is installed
if command -v rg &> /dev/null; then
    # Alias grep to rg if ripgrep is installed
    alias grep='rg'
fi

# Alias's to show disk space and space used in a folder
alias diskspace="du -S | sort -n -r |more"
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias mountedinfo='df -hT'


# FUNCTIONS 
#

# IP address lookup
alias whatismyip="whatsmyip"
function whatsmyip () {
    # Detectar interfaz activa (excluyendo loopback y docker)
    local iface
    iface=$(ip route | grep '^default' | awk '{print $5}')

    # IP interna
    if command -v ip &> /dev/null; then
        echo -n "Internal IP ($iface): "
        ip addr show "$iface" | grep "inet " | awk '{print $2}' | cut -d/ -f1
    else
        echo -n "Internal IP ($iface): "
        ifconfig "$iface" | grep "inet " | awk '{print $2}'
    fi

    # IP externa
    echo -n "External IP: "
    curl -4 ifconfig.me 2>/dev/null
    echo
}



# load env
. "$HOME/.cargo/env"

eval "$(starship init zsh)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
