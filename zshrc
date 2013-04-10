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
    ~/scripts/solarize dark
fi
# prevents bug where .zshenv isn't sourced in tmux sessions 
# should this go in .tmux.conf?
if [ "$TERM" = "screen-256color" ] ; then
    source ~/.zshenv
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
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias pull='git pull origin master'
alias push='git push origin master'

# TODO: use the -z operator to do nothing if $1 is empty
view(){ mupdf ~/docs/*"$1"* &; }

# These lines ensure completions are as verbose as possible
zstyle ':completion:*' verbose yes
zstyle 'completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ”

# TODO: port this to ZSH completion
# Jason Ryan's notes utility
# n() {
# local arg files=(); for arg; do files+=( ~/".notes/$arg" ); done
# ${EDITOR:-vi} "${files[@]}"
# }

# nls() {
# tree -CR --noreport $HOME/.notes | awk '{ 
    # if (NF==1) print $1; 
    # else if (NF==2) print $2; 
    # else if (NF==3) printf "  %s\n", $3 
    # }'
# }
# 
 # TAB completion for notes
# _notes() {
# local files=($HOME/.notes/**/"$2"*)
    # [[ -e ${files[0]} ]] && COMPREPLY=( "${files[@]##~/.notes/}" )
# }
# complete -o default -F _notes n
