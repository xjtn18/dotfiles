-- Change directory commands
vim.cmd('command! DEV e ~/dev')
vim.cmd('command! WID e ~/dev/notes/personal/WID.txt')
vim.cmd('command! ALAC e ~/dev/dotfiles/alacritty.toml')
vim.cmd('command! PC e ~/dev/dotfiles/nvim/plugin_config/init.lua')
vim.cmd('command! BRC e ~/.bashrc')

vim.cmd('command! PLAY e ~/dev/playground')
vim.cmd('command! PLAYPY e ~/dev/playground/python/main.py')
vim.cmd('command! PLAYJS e ~/dev/playground/javascript/test/test.ts')

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

function Kill_other_buffers()
  -- Save the current cursor position
  local winview = vim.fn.winsaveview()

  -- Delete all buffers and open netrw
  vim.api.nvim_command('%bd')
  vim.api.nvim_command('edit #')

  -- Restore the cursor position
  vim.fn.winrestview(winview)
end

-- Map the function to a custom command
vim.api.nvim_command('command! KE lua Kill_other_buffers()')

function Kill_attached_lsp_clients()
  local clients = vim.lsp.get_active_clients()

  local clientIds = {}
  for _, client in ipairs(clients) do
    table.insert(clientIds, client.id)
  end

  -- Stopping all clients by passing the array of client IDs
  vim.lsp.stop_client(clientIds, true) -- true for forceful stop
end

-- Kill every f*cking LSP right now, once and for all
vim.api.nvim_command('command! KL lua Kill_attached_lsp_clients()')
