-- Set the leader key
vim.g.mapleader = " "

function source_config()
  -- Source init.vim and lua/config.lua (this file)
  vim.api.nvim_command('luafile ' .. vim.fn.stdpath('config') .. '/init.lua')

  -- Trigger FileType autocmd manually (so that any file-specific config will execute)
  vim.api.nvim_command('silent! doautocmd FileType')
end

-- Function for quickly zooming in/out
function adjust_font_size(amt)
  local size = tonumber(string.match(vim.o.guifont, "h(%d+)")) + amt
  vim.cmd('set guifont=BlexMono\\ Nerd\\ Font\\ Mono:h' .. size)
end



-- MAPPINGS

-- Create the mappings for tabs where leader + number 'n' takes you the 'nth' tab.
for i = 1, 9 do
  vim.api.nvim_set_keymap('n', '<leader>' .. i, ':tabn ' .. i .. '<CR>', { noremap = true, silent = true })
end

vim.api.nvim_set_keymap('n', '<Leader>+', ':lua adjust_font_size(1)<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>-', ':lua adjust_font_size(-1)<CR>', {noremap = true, silent = true})

-- Mappings
vim.api.nvim_set_keymap('n', '<leader>s', ':lua source_config()<cr>', { noremap = true, silent = true })

vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeFindFileToggle<cr>zz', { noremap = true })

-- Telescope mappings
vim.api.nvim_set_keymap('n', '<leader>f', ':Telescope find_files<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>g', ':Telescope live_grep<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':Telescope buffers<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>r', ':Telescope resume<cr>', { noremap = true })

vim.api.nvim_set_keymap('n', '<Esc>', ':nohl<cr>:match none<cr>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader><Tab>', '<C-^>', { noremap = true })

vim.api.nvim_set_keymap('n', 'U', '<C-r>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>=', 'gg=G<C-o>zz', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>il', ':e ~/AppData/Local/nvim/init.lua<cr>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>pe', ':e ~/AppData/Local/nvim-data<cr>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>t', ':tabnew<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>kt', ':tabclose<cr>', { noremap = true })

-- Moving between windows
vim.api.nvim_set_keymap('n', '<leader>wh', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>wj', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>wk', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>wl', '<C-w>l', { noremap = true })

vim.api.nvim_set_keymap('n', 'H', 'Hzz', { noremap = true })
vim.api.nvim_set_keymap('n', 'L', 'Lzz', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>o', '<C-o>zz', { noremap = true })

vim.api.nvim_set_keymap('v', '<leader>/', ':s#^#// <cr> :nohl<cr>', { noremap = true })

-- Create/delete lines in normal mode
vim.api.nvim_set_keymap('n', '<cr>', ':a<cr><cr>.<cr>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<bs>', 'dd', { noremap = true })


