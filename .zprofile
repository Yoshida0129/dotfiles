# Executes commands at login pre-zshrc.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#
# Browser
#

if [[ "$OSTYPE" == darwin* ]]; then
  export BROWSER='open'
fi

if [[ -z "$LANG" ]]; then
  export LANG='ja_JP.UTF-8'
fi

typeset -gU cdpath fpath mailpath path

path=(
  /usr/local/{bin,sbin}
  $path
)

export LESS='-F -g -i -M -R -S -w -X -z-4'

if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

export ZDOTDIR="$HOME/dotfiles/"

eval "$(/opt/homebrew/bin/brew shellenv)"
