#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ "$TERM" = "linux" ] ; then
    echo -en "\e]PF002b36" #brblack
    echo -en "\e]P7073642" #black
    echo -en "\e]PE586e75" #brgreen
    echo -en "\e]PC657b83" #bryellow
    echo -en "\e]PB839496" #brblue
    echo -en "\e]PA93a1a1" #brcyan
    echo -en "\e]P0eee8d5" #white
    echo -en "\e]P8fdf6e3" #brwhite
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
    
PATH="${PATH}:/home/bertie/.gem/ruby/1.9.1/bin"


alias rm='rm -i'
# alias emacs='emacs -nw'
alias ls='ls --color=auto'
alias snettex='sudo netcfg utexas'
alias sneteds='sudo netcfg steds'
alias snethme='sudo netcfg mynetwork'
alias beut='newsbeuter'
alias simplenote='vim -c :Simplenote\ -l -c wincmd\ j -c q'
alias rtt='read2text'
alias pac='sudo pacman -S'
alias sshutdown='sudo shutdown -h -P now'
alias redshift='redshift -l 30.2:97.7 -t 5500:3600 &'
alias sqlstart='sudo /etc/rc.d/mysqld start'
alias sqlconn='mysql -h localhost -u root -p'
PS1='[\u@\h \W]\$ '

[ -n "$WINDOWID" ] && transset-df -i $WINDOWID >/dev/null

bi () {
cp -a $1 /dev/shm
cd /dev/shm/$1
here=`pwd`
echo you are here $here
}
