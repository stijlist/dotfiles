PATH=~/.cargo/bin:~/go/bin:/opt/local/bin:/opt/local/sbin:$PATH
PATH=$LLVM/bin:$PATH
PATH=~/bin:$PATH
export PATH=$PATH:/Library/Java/JavaVirtualMachines/graalvm-ce-java11-21.1.0/Contents/Home/bin
export SDKROOT=$(xcrun --show-sdk-path)
# source /opt/local/share/chruby/chruby.sh
export PATH="/opt/homebrew/opt/python@3.9/libexec/bin:$PATH"
export PATH=$PATH:~/zig
export PATH=$PATH:~/zls
alias gap="git add -p"
alias gcp="git checkout -p"
alias gdp="git diff -p"
alias grp="git reset -p"
alias gs="git status"
alias gd="git diff"
alias gl="git log"
eval "$(/opt/homebrew/bin/brew shellenv)"
