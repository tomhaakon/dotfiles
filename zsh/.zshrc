# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1
alias t='tmux'
#alias v='vim'


alias countlines='count_lines_in_files_recursive'

alias banan='sudo tail -f /var/log/mysql/mysql.log | grep --color -E "banan"'

alias psdev='cd /var/www/html/psdev'
alias web='cd /var/www/html/'

alias restartweb='sudo systemctl restart php8.1-fpm.service && sudo systemctl restart nginx.service && echo "restart ok"'
source ~/.dotfiles/.zshrc_aliases
# Start tmux if not already running
# 
#[ -z "$TMUX" ] && command -v tmux &> /dev/null && tmux

# Colorized ls
alias ls='exa -h --group-directories-first --color=auto'
alias ll='exa -a --group-directories-first --color=auto'
#alias ls='gls --color=auto --group-directories-first'

function count_lines_in_files_recursive() {
    local target_dir="${1:-.}" # Use the first argument as the directory, default to current directory if none provided
    find "$target_dir" -type f -exec wc -l {} + | awk '{total += $1} END{print total}'
}

#sette vim farger
#source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
#bindkey -e
bindkey -v
bindkey -M vicmd 'v' edit-command-line

#set -g mouse on
# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#flameshot
export QT_QPA_PLATFORM=wayland

find_console () {
    local dir=$(pwd)

    while [[ "$dir" != "/" ]]; do
        if [[ -f "$dir/bin/console" ]]; then
            echo "$dir/bin/console"
            return
        fi
        dir=$(dirname "$dir")
    done

    echo "Error: Could not find bin/console in the file hierarchy."
    return 1
}

# I stedet for å gå til rotmappen av prestashop/symfony og kjøre bin/console, kan du bruke denne funksjonen hvor som helst. Eksempel binconsole prestashop:module install mymodule
binconsole() {
    local console_path=$(find_console)

    if [[ $? -eq 0 ]]; then
        sudo -u www-data php "$console_path" "$@"
    else
        echo "Error: bin/console not found. Are you in a PrestaShop project?"
        return 1
    fi
}

psmod() { # bruk: mod install|uninstall|reset i en modulmappe for å slippe å gå til rot og kjøre bin/console prestashop:module install mymodule
    DIRNAME=$(basename "$(pwd)")

    # Sjekk om vi er i en PrestaShop-modulmappe
    if [[ ! -f "$DIRNAME.php" && ! -f "config.xml" ]]; then
        echo "Error: You are not in a PrestaShop module directory."
        return 1
    fi

    # Utfør handlingen
    ACTION=$1
    binconsole prestashop:module "$ACTION" "$DIRNAME"
}
