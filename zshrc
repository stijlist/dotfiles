# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=3000
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

# old prompt that includes username, hostname
#PROMPT="[%n@%m %c]%# "

# new prompt, only directory
PROMPT="%{$fg[blue]%}[%c]%# "
#PROMPT="%{\e[0;31m%}%m%{\e[0m%}"
RPROMPT='%{$fg[blue]%} $(prompt_char)$(~/scripts/git-cwd-info.sh)%{$reset_color%}'
#$(/usr/local/rvm/bin/rvm-prompt) if rvm prompt is desired


function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '○'
}

if [ "$TERM" = "linux" ] ; then
    echo -en "\e]P8002b36" #brblack
    echo -en "\e]P0073642" #black
    echo -en "\e]PA586e75" #brgreen
    echo -en "\e]PB657b83" #bryellow
    echo -en "\e]PC839496" #brblue
    echo -en "\e]PE93a1a1" #brcyan
    echo -en "\e]P7eee8d5" #white
    echo -en "\e]PFfdf6e3" #brwhite
    echo -en "\e]P3b58900" #yellow
    echo -en "\e]P9cb4b16" #brred
    echo -en "\e]P1dc322f" #red
    echo -en "\e]P5d33682" #magenta
    echo -en "\e]PD6c71c4" #brmagenta
    echo -en "\e]P4268bd2" #blue
    echo -en "\e]P62aa198" #cyan
    echo -en "\e]P2859900" #green
    clear #for background artifacting
fi


# Transparency with xcompmgr
#[ -n "$WINDOWID" ] && transset-df -i $WINDOWID >/dev/null

# alias l='ls --color=auto'
alias l='ls'
alias simplenote='vim -c :Simplenote\ -l -c wincmd\ j -c q'
alias pac='sudo pacman -S'
alias sshutdown='sudo shutdown -h -P now'
alias redshift='redshift -l 30.2:97.7 -t 5500:3600 &'
alias susp='sudo pm-suspend'
alias find='find -L'
