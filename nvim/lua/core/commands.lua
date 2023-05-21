-- Change directory commands
vim.cmd('command! DEV lua vim.cmd("e ~/dev")')
vim.cmd('command! PLAY lua vim.cmd("e ~/dev/playground")')
vim.cmd('command! WID lua vim.cmd("e ~/dev/notes/personal/WID.org")')
vim.cmd('command! ALAC lua vim.cmd("e ~/AppData/Roaming/alacritty/alacritty.yml")')

-- Change into current open file's directory
vim.cmd('command! CD lua vim.cmd("lcd %:p:h")')

-- Kill all buffers
vim.cmd('command! KA lua vim.cmd("bufdo bd")')

-- PlugInstall and PlugClean
vim.cmd('command! PI lua vim.cmd("PlugInstall")')
vim.cmd('command! PC lua vim.cmd("PlugClean")')

-- Change into the (recent) project you've been working on
vim.cmd('command! AP lua vim.cmd("cd cvo_website")')

-- Return to dashboard
vim.cmd('command! D lua vim.cmd("Dashboard")')
