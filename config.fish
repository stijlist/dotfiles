# git clone https://github.com/oh-my-fish/plugin-foreign-env.git
set fish_function_path $fish_function_path ~/plugin-foreign-env/functions
fenv source ~/.profile
# fenv source ~/.nix-profile/etc/profile.d/nix.sh

alias g="git status"
alias gc="git commit"
alias gap="git add -p"
alias gcp="git checkout -p"
alias gca="git commit --amend"
alias gdp="git diff -p"
alias gdc="git diff --cached"
alias grp="git reset -p"
alias gs="git stash"
alias gsp="git stash pop"
alias gss="git stash show"
alias gd="git difftool"
alias gl="git lg"
alias gll="git log"
alias gri="git revise -i"
set -g -x EDITOR vim
set -g -x NOTESDIR ~/notes

function fish_greeting
  echo "Here's what's at the top of your TODO list:"
  head -n 3 $NOTESDIR/next.txt
end
funcsave fish_greeting

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

function job_count
  set -l count (jobs | wc -l | string trim)
  if not test $count -eq 0
    echo " ($count)"
  end
end

function fish_prompt
  if test -d .git
    printf '%s%s%s:%s:%s%s> ' (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (parse_git_branch) (job_count)
  else
    printf '%s%s%s%s> ' (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (job_count)
  end
end
