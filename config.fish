set -g -x PATH ~/scripts $PATH
set -g -x PATH /usr/local/bin $PATH
set -g -x PATH /usr/local/opt/ruby/bin $PATH 
set -g -x PATH /Applications/Postgres.app/Contents/MacOS/bin $PATH 
set -g -x EDITOR vim
set -g -x GOPATH ~/source/go
set -g -x PATH $GOPATH/bin $PATH
set -g -x PLAN9 /Users/bert/plan9
set -g -x PATH $PATH $PLAN9/bin
set -g -x STACKFILE ~/notes/stack.taskpaper
set -g -x NEXTFILE ~/notes/next.taskpaper
alias clear-todos "organize-list ~/notes/next.taskpaper"
alias conflicts "git ls-files -u | awk '{print $4}' | sort -u"
alias merge "vim (git status -s | grep '^UU' | awk '{print $2}')"
. /usr/local/share/chruby/chruby.fish

set fish_git_dirty_color red
set fish_git_not_dirty_color green

function parse_git_branch
  set -l branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
  set -l git_diff (git diff)

  if test -n "$git_diff"
    echo (set_color $fish_git_dirty_color)$branch(set_color normal)
  else
    echo (set_color $fish_git_not_dirty_color)$branch(set_color normal)
  end
end

function fish_prompt
  if test -d .git
    printf '%s@%s %s%s%s:%s> ' (whoami) (hostname|cut -d . -f 1) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (parse_git_branch)
  else
    printf '%s@%s %s%s%s> ' (whoami) (hostname|cut -d . -f 1) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
  end
end
