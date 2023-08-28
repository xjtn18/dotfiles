-- Change directory commands
vim.cmd('command! DEV e ~/dev')
vim.cmd('command! PLAY e ~/dev/playground')
vim.cmd('command! WID e ~/dev/notes/personal/WID.org')
vim.cmd('command! ALAC e ~/dotfiles/alacritty.yml')
vim.cmd('command! AP cd cvo_website')
vim.cmd('command! LAMB cd intellimind/Lambdas')
vim.cmd('command! PC e ~/dotfiles/nvim/lua/core/plugin_config/init.lua')

-- Change into current open file's directory
vim.cmd('command! CD lcd %:p:h')

-- Return to dashboard
vim.cmd('command! D Dashboard')

-- highlight all occurences (without auto moving cursor to next occurence)
vim.api.nvim_command('command! -nargs=1 MS :match Search /<args>/')

-- Copy the relative path to the current file
vim.api.nvim_command("command! CRP call setreg('+', expand('%'))")

-- Kill all buffers
vim.api.nvim_command("command! KA :%bd|e.")

function open_netrw_keep_pos()
  -- Save the current cursor position
  local winview = vim.fn.winsaveview()

  -- Delete all buffers and open netrw
  vim.api.nvim_command('%bd')
  vim.api.nvim_command('edit #')

  -- Restore the cursor position
  vim.fn.winrestview(winview)
end

-- Map the function to a custom command
vim.api.nvim_command('command! KE lua open_netrw_keep_pos()')
