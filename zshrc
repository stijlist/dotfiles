# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=30000
setopt appendhistory autocd beep extendedglob nomatch
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/bertie/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall
# Colors
autoload -U colors
colors
setopt prompt_subst

# new prompt, only directory
PROMPT="%{$fg[blue]%}[%c]%# "
#PROMPT="%{\e[0;31m%}%m%{\e[0m%}"
RPROMPT='%{$fg[blue]%} $(prompt_char)$(~/scripts/git-cwd-info.sh)%{$reset_color%}'

# install z
. /home/bert/scripts/z/z.sh
# autocomplete bash completion scripts
autoload -U bashcompinit
bashcompinit
# autocomplete teamocil commands
compctl -g '~/.teamocil/*(:t:r)' teamocil

# tmux doesn't source .zshenv; workaround
if [ "$TERM" = "screen-256color" ] ; then
    source ~/.zshenv
fi

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '○'
}

if [ "$TERM" = "linux" ] ; then
    ~/scripts/solarize dark
fi

alias l='ls'
alias v='vim'
alias simplenote='vim -c :Simplenote\ -l -c wincmd\ j -c q'
alias pget='sudo pacman -S'
alias sshutdown='sudo shutdown -h -P now'
alias redshift='redshift -l 30.2:97.7 -t 5500:3600 &'
alias find='find -L'
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias pull='git pull origin master'
alias push='git push origin master'
alias add='git add'
alias commit='git commit'
alias sync-repositories='sudo pacman -Syy'
alias update-system='sudo pacman -Syu'
alias ..='cd ..'
alias ...='cd ../..'
# TODO: This doesn't work; I think it runs the commands in su's context
# alias resudo='sudo !!'

# TODO: use the -z operator to do nothing if $1 is empty
view(){ mupdf ~/docs/*"$1"* &; }

# These lines ensure completions are as verbose as possible
zstyle ':completion:*' verbose yes
zstyle 'completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ”
