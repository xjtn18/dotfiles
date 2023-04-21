@echo off

set DOTFILES_DIR=%~dp0

mklink /H %USERPROFILE%\.rgignore "%DOTFILES_DIR%\.rgignore"
mklink /H %USERPROFILE%\AppData\Local\nvim\init.vim "%DOTFILES_DIR%\init.vim"

echo Dotfiles have been linked.
