-- Change directory commands
vim.cmd('command! DEV e ~/dev')
vim.cmd('command! PLAY e ~/dev/playground')
vim.cmd('command! WID e ~/dev/notes/personal/WID.org')
vim.cmd('command! ALAC e ~/dotfiles/alacritty.yml')

-- Change into current open file's directory
vim.cmd('command! CD lcd %:p:h')

-- Kill all buffers
vim.cmd('command! KA bufdo bd')

-- PlugInstall and PlugClean
vim.cmd('command! PI PlugInstall')
vim.cmd('command! PC PlugClean')

-- Change into the (recent) project you've been working on
vim.cmd('command! AP cd cvo_website')

-- Return to dashboard
vim.cmd('command! D Dashboard')

-- highlight all occurences (without auto moving cursor to next occurence)
vim.api.nvim_command('command! -nargs=1 MS :match Search /<args>/')

