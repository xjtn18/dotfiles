-- Set the leader key
vim.g.mapleader = " "

function Source_config()
  -- Source init.vim and lua/config.lua (this file)
  vim.api.nvim_command('luafile ' .. vim.fn.stdpath('config') .. '/init.lua')

  -- Trigger FileType autocmd manually (so that any file-specific config will execute)
  vim.api.nvim_command('silent! doautocmd FileType')
end

-- MAPPINGS

-- Create the mappings for tabs where leader + number 'n' takes you the 'nth' tab.
for i = 1, 9 do
  vim.api.nvim_set_keymap('n', '<leader>' .. i, ':tabn ' .. i .. '<CR>', { noremap = true, silent = true })
end

-- Mappings
vim.api.nvim_set_keymap('n', '<leader>s', ':lua Source_config()<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>e', [[<Cmd>lua vim.diagnostic.open_float(0, {scope="line"})<cr>]],
  { noremap = true, silent = true })

-- Telescope mappings
vim.api.nvim_set_keymap('n', '<leader>f', ':Telescope find_files<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>g', ':Telescope live_grep<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>b', ':Telescope buffers<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>r', ':Telescope resume<cr>', { noremap = true })

vim.api.nvim_set_keymap('n', '<Esc>', ':nohl<cr>:match none<cr>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader><Tab>', '<C-^>', { noremap = true })

vim.api.nvim_set_keymap('n', 'U', '<C-r>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>=', 'gg=G<C-o>zz', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>il', ':e ~/dev/dotfiles/nvim/init.lua<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ip', ':e ~/dev/dotfiles/nvim/lua/plugins.lua<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>ic', ':e ~/dev/dotfiles/nvim/lua/plugin_config<cr>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>pe', ':e ~/AppData/Local/nvim-data<cr>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>t', ':tabnew<cr>', { noremap = true })

-- Moving between windows
vim.api.nvim_set_keymap('n', '<leader>wh', '<C-w>h', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>wj', '<C-w>j', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>wk', '<C-w>k', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>wl', '<C-w>l', { noremap = true })

vim.api.nvim_set_keymap('n', 'H', 'Hzz', { noremap = true })
vim.api.nvim_set_keymap('n', 'L', 'Lzz', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>o', '<C-o>zz', { noremap = true })

-- Comment out (JS) entire visual selection
vim.api.nvim_set_keymap('v', '<leader>/', ':s#^#// <cr> :nohl<cr>', { noremap = true })

-- Create/delete lines in normal mode
vim.api.nvim_set_keymap('n', '<s-cr>', ':a<cr><cr>.<cr>k', { noremap = true })

-- NOTE :: For some reason, after allowing alacritty to send shift-backspace, this is how it sends it to neovim.
vim.api.nvim_set_keymap('n', '<c-s-h>', ':lua DeleteNextLine()<CR>', { noremap = true, silent = true }) -- ACTIVATED USING SHIFT+BACKSPACE

function DeleteNextLine()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local current_col = vim.api.nvim_win_get_cursor(0)[2]
  vim.api.nvim_buf_set_lines(0, current_line, current_line + 1, false, {})
  vim.api.nvim_win_set_cursor(0, { current_line, current_col })
end

vim.api.nvim_set_keymap('n', '<bs>', 'dd', { noremap = true })

-- Yank a whole file
vim.api.nvim_set_keymap('n', '<leader>yf', 'ggyG<C-o>zz', { noremap = true })

-- Open LSP code actions in Telescope
vim.api.nvim_set_keymap('n', '<leader>a', [[<cmd>lua vim.lsp.buf.code_action()<cr>]], { noremap = true, silent = true })
-- Keymap for toggling Netrw
vim.api.nvim_set_keymap('n', '<leader>n', ':lua ToggleNetrw()<CR>', { noremap = true, silent = true })

-- Function to toggle Netrw
function ToggleNetrw()
  -- Check if the current buffer's filetype is 'netrw'
  if vim.bo.filetype == 'netrw' then
    -- Try to return to the previous buffer stored in a global variable
    if vim.g.last_netrw_buf and vim.fn.bufexists(vim.g.last_netrw_buf) == 1 then
      vim.cmd('buffer ' .. vim.g.last_netrw_buf)
    else
      -- If the previous buffer does not exist, just close Netrw
      vim.cmd('bd')
    end
  else
    -- Save the current buffer number to a global variable
    vim.g.last_netrw_buf = vim.fn.bufnr()
    -- Open Netrw
    vim.cmd('Ex')
  end
end

function AdjustFontSize(delta)
  local guifont = table.concat(vim.opt.guifont, ", ")
  local font_name, font_size = string.match(guifont, "^(.*):h(%d+)$")
  if font_name and font_size then
    font_size = tonumber(font_size) + delta
    if font_size < 8 then font_size = 8 end -- Set a minimum font size if needed
    vim.opt.guifont = string.format("%s:h%d", font_name, font_size)
  end
end

-- Zoom behavior for GUI nvim
vim.api.nvim_set_keymap('n', '<C-ScrollWheelUp>', '<cmd>lua AdjustFontSize(1)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-ScrollWheelDown>', '<cmd>lua AdjustFontSize(-1)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-ScrollWheelUp>', '<Esc><cmd>lua AdjustFontSize(1)<CR>a',
  { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-ScrollWheelDown>', '<Esc><cmd>lua AdjustFontSize(-1)<CR>a',
  { noremap = true, silent = true })


-- Unison sync command
vim.api.nvim_set_keymap('n', '<F5>', '', {
  noremap = true,
  callback = function()
    local handle
    handle = vim.loop.spawn('unison', {
      detached = true
    }, function(code)
      handle:close()

      if code == 0 then
        vim.schedule(function()
          vim.notify('Unison sync complete', vim.log.levels.INFO)
        end)
      end

      if code ~= 0 then
        vim.schedule(function()
          vim.notify('Unison failed with code ' .. code, vim.log.levels.ERROR)
        end)
      end
    end)
  end,
  silent = true
})
