#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PATH="${PATH}:/home/bertie/.gem/ruby/1.9.1/bin"
~/scripts/solarize dark

# alias rm='rm -i'
# alias emacs='emacs -nw'
alias ls='ls --color=auto'
alias simplenote='vim -c :Simplenote\ -l -c wincmd\ j -c q'
alias rtt='read2text'
alias redshift='redshift -l 30.2:97.7 -t 5500:3600 &'
PS1='[\u@\h \W]\$ '

# Jason Ryan's notes utility
shopt -s globstar
nv() {
local arg files=(); for arg; do files+=( ~/".notes/$arg" ); done
${EDITOR:-vi} "${files[@]}"
}

nls() {
tree -CR --noreport $HOME/.notes | awk '{ 
    if (NF==1) print $1; 
    else if (NF==2) print $2; 
    else if (NF==3) printf "  %s\n", $3 
    }'
}

 # TAB completion for notes
_notes() {
local files=($HOME/.notes/**/"$2"*)
    [[ -e ${files[0]} ]] && COMPREPLY=( "${files[@]##~/.notes/}" )
}
complete -o default -F _notes nv

