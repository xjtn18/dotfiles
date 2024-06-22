@echo off

set DOTFILES_DIR=%~dp0

git pull

:: Remove any existing version of these files
del %USERPROFILE%\.rgignore
del %USERPROFILE%\AppData\Roaming\alacritty\alacritty.toml
del %USERPROFILE%\AppData\Roaming\lazygit\config.yml
if exist %USERPROFILE%\AppData\Local\nvim rmdir /S /Q %USERPROFILE%\AppData\Local\nvim

:: Hardlink the files
mklink /H %USERPROFILE%\.rgignore "%DOTFILES_DIR%\.rgignore"
mklink /H %USERPROFILE%\AppData\Roaming\alacritty\alacritty.toml "%DOTFILES_DIR%\alacritty.toml"
mklink /H %USERPROFILE%\AppData\Roaming\lazygit\config.yml "%DOTFILES_DIR%\lazygit.yml"
mklink /J %USERPROFILE%\AppData\Local\nvim "%DOTFILES_DIR%\nvim"

echo Finished ~ dotfiles are now synced.
