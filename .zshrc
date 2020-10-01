#!/bin/sh
autoload -U compinit; compinit -u
autoload history-search-end

export LANG=ja_JP.UTF-8
export PATH=$PATH:~/.anyenv/envs/ndenv/versions/v6.9.4/lib/node_modules/vue-cli/bin
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
export PATH="$PATH":"$HOME/.pub-cache/bin"
export PATH=$PATH:"$HOME/flutter/bin"
export PATH=$PATH:"$HOME/Tool"
export EDITOR=vim
export NO_UPDATE_NOTIFIER=true

alias reload="exec $SHELL -l"
alias vi="nvim"
alias gls="gls --color"
alias js="osascript -l JavaScript"
alias aptitude='nocorrect aptitude'
alias mysql='nocorrect mysql'
alias sudo='nocorrect sudo'
alias projects="~/projects"

bindkey -r '^J' # Ctrl-j

# cd -<tab>で以前移動したディレクトリを表示
setopt auto_pushd
setopt auto_menu
setopt auto_list
# コマンドラインの引数でも補完を有効にする（--prefix=/userなど）
setopt magic_equal_subst
setopt auto_cd

zstyle ':completion:*' list-colors ''
# 大文字小文字を区別しない（大文字を入力した場合は区別する）
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

function cd() {
  builtin cd "$@" && ls
}

# add file arrow
function powerline_precmd() {
  PS1="$(powerline-shell --shell zsh $?)"
}

function install_powerline_precmd() {
  for s in "${precmd_functions[@]}"; do
    if [ "$s" = "powerline_precmd" ]; then
      # 入力途中に候補をうっすら表示
      # zplug "zsh-users/zsh-autosuggestions"
      #
      # # コマンドを種類ごとに色付け
      # zplug "zsh-users/zsh-syntax-highlighting", defer:2
      #
      # # ヒストリの補完を強化する
      # zplug "zsh-users/zsh-history-substring-search", defer:3
      return
    fi
  done
  precmd_functions+=(powerline_precmd)
}

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# eval "$(anyenv init -)"

if [ "$TERM" != "linux" ]; then
  install_powerline_precmd
fi

# brew files
if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap
fi
