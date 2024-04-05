# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1
alias t='tmux'
alias v='vim'

alias psdev='cd /var/www/html/psdev'
alias web='cd /var/www/html/'

alias restartweb='sudo systemctl restart php8.1-fpm.service && sudo systemctl restart nginx.service && echo "restart ok"'

source ~/.dotfiles/.zshrc_aliases
# Start tmux if not already running
# 
[ -z "$TMUX" ] && command -v tmux &> /dev/null && tmux

# Colorized ls
alias ls='exa -h --group-directories-first --color=auto'
alias ll='exa -a --group-directories-first --color=auto'
#alias ls='gls --color=auto --group-directories-first'

#sette vim farger
#source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e
set -g mouse on
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
export QT_QPA_PLATFORM=xcb

