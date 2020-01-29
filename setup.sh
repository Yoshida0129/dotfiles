#!/bin/sh
cd `dirname $0`

OS="unknown"
if [ "$(uname)" == 'Darwin' ]; then
    echo setup for mac
    OS="mac"
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
    echo setup for linux
    OS="linux"
else
    echo "OS is unknown. exit setup."
    exit -1
fi

function deploy() {
    echo make link
    ln -fnsv ~/dotfiles/vimfiles/.vimrc ~/.vimrc
    ln -fnsv ~/dotfiles/vimfiles/.vim ~/.vim
    ln -fnsv ~/dotfiles/.gitconfig ~/.gitconfig
    ln -fnsv ~/dotfiles/.zprofile ~/.zprofile
    ln -fnsv ~/dotfiles/.zashrc ~/.zshrc
    ln -fnsv ~/dotfiles/.Brewfile ~/.Brewfile

    touch ~/.zprofile_local
    touch ~/.gitconfig.local
}

function deploy_app() {
    if [ "$OS" == "mac" ]; then
        ln -fnsv ~/dotfiles/vscode ~/Library/Application\ Support/Code/User
        ln -fnsv ~/dotfiles/hyper ~
    fi
}

function initialize_vim() {
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > ~/dotfiles/installer.sh
    sh ~/dotfiles/installer.sh ~/.vim/dein
}

function undeploy() {
    unlink ~/.vimrc
    unlink ~/.vim
    unlink ~/.gitconfig
    unlink ~/.zprofile
    unlink ~/.Brewfile

    if [ "$OS" == "mac" ]; then
        unlink ~/Library/Application\ Support/Code/User/setting.json
        unlink ~/.hyper.js
    elif [ "$OS" == 'linux' ]; then
        echo uninstall for linux
    fi
}

function initialize() {
    if [ "$OS" == "mac" ]; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        brew bundle --global
    fi
}

if [ "$1" == "--undeploy" ]; then
    echo ---- dotfiles undeploy start ----
    undeploy
    echo ---- dotfiles undeploy end ----
elif [ "$1" == "--init" ]; then
    echo ---- initialize start ----
    deploy
    initialize
    deploy_app
    initialize_vim
    echo ---- initialize end ----
else
    echo ---- dotfiles setup start ----
    deploy
    deploy_app
    initialize_vim
    echo ---- dotfiles setup end ----
fi