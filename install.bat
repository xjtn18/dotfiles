@echo off

set DOTFILES_DIR=%~dp0

git pull

:: Remove any existing version of these files
del %USERPROFILE%\.rgignore
if exist %USERPROFILE%\AppData\Local\nvim rmdir /S /Q %USERPROFILE%\AppData\Local\nvim

:: Hardlink the files
mklink /H %USERPROFILE%\.rgignore "%DOTFILES_DIR%\.rgignore"
mklink /J %USERPROFILE%\AppData\Local\nvim "%DOTFILES_DIR%\nvim"

echo Finished. Dotfiles are now synced.

