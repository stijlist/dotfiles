set -g -x PATH ~/bin $PATH
set -g -x PATH /usr/local/bin $PATH
set -g -x PATH ~/fuchsia/.jiri_root/bin $PATH
set -g -x PATH ~/.cargo/bin $PATH
set -g -x PATH ~/fuchsia/out/build-zircon/tools $PATH
set -g -x EDITOR vim
set -g -x NOTESDIR ~/notes
set -g -x GOPATH $HOME/go


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
  set -l count (jobs | wc -l)
  if not test $count -eq 0
    echo " ($count)"
  end
end

function jiri_changed_repos
  if test (pwd) = ~/fuchsia
    set -l changed (jiri status | grep -Eo '^[a-zA-Z\/_]+: $' | tr -d ': ' | xargs | sed -e 's/ /,/g' 2> /dev/null)
    echo " " (set_color $fish_git_dirty_color) "($changed)" (set_color $fish_git_not_dirty_color)
  end
end

function fx_build_dir
  if test -e ./.fx-build-dir
    cat ./.fx-build-dir | tr -d '\n'
  end
end

function fish_prompt
  if test -d .git
    printf '%s%s%s:%s:%s%s> ' (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (fx_build_dir) (parse_git_branch) (job_count)
  else
    printf '%s%s%s%s> ' (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (job_count)
  end
end
