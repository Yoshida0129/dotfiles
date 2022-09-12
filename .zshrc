#!/bin/sh
autoload -U compinit; compinit -u
autoload history-search-end

export LANG=ja_JP.UTF-8
export GOPATH=$HOME/go
export PATH=$HOME/Library/Python/3.8/bin
export PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH
export EDITOR=vim
export NO_UPDATE_NOTIFIER=true
export HISTFILE=~/dotfiles/.zsh_history
export XDG_CONFIG_HOME="$HOME/.config"
export LSCOLORS=gxfxcxdxfxegedabagacad
# anyenv
export PATH="$HOME/.anyenv/bin:$PATH"
eval "$(anyenv init -)"

alias reload="exec $SHELL -l"
alias vi="nvim"
alias gls="gls --color"
alias js="osascript -l JavaScript"
alias aptitude='nocorrect aptitude'
alias mysql='nocorrect mysql'
alias sudo='nocorrect sudo'
alias projects="~/projects"
alias ls='ls -F --color=auto'
alias l="ls -C --color=always"
alias ll="ls -al --color=always"
alias la="ls -A --color=always"
alias gs='git status'
alias LESS='less -R'
# alias gomi='rm'

bindkey -r '^J' # Ctrl-j

# cd -<tab>で以前移動したディレクトリを表示
setopt auto_pushd
setopt auto_menu
setopt auto_list
# コマンドラインの引数でも補完を有効にする（--prefix=/userなど）
setopt magic_equal_subst
setopt auto_cd
setopt share_history

zstyle ':completion:*' list-colors ''
# 大文字小文字を区別しない（大文字を入力した場合は区別する）
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*:default' menu select=1

function cd() {
  builtin cd "$@" && ls
}

# add file arrow
function powerline_precmd() {
  PS1="$(powerline-shell --shell zsh $?)"
}

if [ "$TERM" != "linux" ]; then
  precmd_functions+=(powerline_precmd)
fi

# brew files
if [ -f $(brew --prefix)/etc/brew-wrap ];then
  source $(brew --prefix)/etc/brew-wrap
fi

##### zplug

if [[ ! -d ~/dotfiles/downloads/.zplug ]];then
  git clone https://github.com/zplug/zplug ~/dotfiles/downloads/.zplug
fi

source ~/dotfiles/downloads/.zplug/init.zsh

# 自分自身をプラグインとして管理
zplug "zplug/zplug", hook-build:'zplug --self-manage'
# コマンドをリンクして、PATH に追加し、プラグインは読み込む
zplug load –verbose
# 補完を更に強化する
zplug "zsh-users/zsh-completions"
# git の補完を効かせる
zplug "plugins/git",   from:oh-my-zsh
zplug "peterhurford/git-aliases.zsh"
# 構文のハイライト(https://github.com/zsh-users/zsh-syntax-highlighting)
zplug "zsh-users/zsh-syntax-highlighting"
# コマンド入力途中で上下キー押したときの過去履歴がいい感じに出るようになる
zplug "zsh-users/zsh-history-substring-search"
# 入力途中に候補をうっすら表示
zplug "zsh-users/zsh-autosuggestions"
# コマンドを種類ごとに色付け
zplug "zsh-users/zsh-syntax-highlighting", defer:2
# ヒストリの補完を強化する
zplug "zsh-users/zsh-history-substring-search", defer:3
# 256色表示にする
zplug "chrissicool/zsh-256color"
# コマンドライン上の文字リテラルの絵文字を emoji 化する
zplug "mrowa44/emojify", as:command
# インストールしてないプラグインはインストール
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi
# share_history_setting
HISTSIZE=1000000
SAVEHIST=1000000
# Then, source plugins and add commands to $PATH
zplug load
