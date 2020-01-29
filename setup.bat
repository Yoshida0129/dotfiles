@echo off
mklink %USERPROFILE%\vimfiles\.vimrc %~dp0\_vimrc
mklink /d %USERPROFILE%\vimfiles\.vim %~dp0\vimfiles\.vim
mklink %USERPROFILE%\.gitconfig %~dp0\.gitconfig

mklink /d %AppData%\Code\User %~dp0\vscode

pushd %~dp0
git submodule init
git submodule update
popd