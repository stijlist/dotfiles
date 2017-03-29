set -g -x PATH ~/bin $PATH
set -g -x PATH /usr/local/bin $PATH
set -g -x PATH /Applications/Postgres.app/Contents/Versions/9.4/bin $PATH
set -g -x EDITOR vim
set -g -x NOTESDIR ~/notes
prodcertstatus >/dev/null 2>&1 ;or prodaccess
source /google/data/ro/teams/fish/google.fish

function fish_greeting
  echo "Here's what's at the top of your TODO list:"
  head -n 5 $NOTESDIR/next
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

function fish_prompt
  if test -d .git
    printf '%s %s%s%s:%s> ' (whoami) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (parse_git_branch)
  else
    printf '%s %s%s%s> ' (whoami) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
  end
end
