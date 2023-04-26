@echo off

set DOTFILES_DIR=%~dp0

git pull
del %USERPROFILE%\.rgignore
del %USERPROFILE%\AppData\Local\nvim\init.vim
mklink /H %USERPROFILE%\.rgignore "%DOTFILES_DIR%\.rgignore"
mklink /H %USERPROFILE%\AppData\Local\nvim\init.vim "%DOTFILES_DIR%\init.vim"

echo Dotfiles have been linked.
