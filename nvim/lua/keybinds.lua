vim.g.mapleader = " "

-- Function to simplify keybinding creation
function _Bind(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap or true
  opts.silent = opts.silent or false
  vim.keymap.set(mode, lhs, rhs, opts)
end

function BindNormal(lhs, rhs, opts)
  _Bind('n', lhs, rhs, opts)
end

function BindInsert(lhs, rhs, opts)
  _Bind('i', lhs, rhs, opts)
end

function BindVisual(lhs, rhs, opts)
  _Bind('v', lhs, rhs, opts)
end

-- Keybindings
for i = 1, 9 do
  BindNormal('<leader>' .. i, ':tabn ' .. i .. '<CR>', { silent = true })
end

BindNormal('<leader>s', ':w<cr>')
BindNormal('<leader>q', ':q<cr>')
BindNormal('<leader>!', ':q!<cr>')
BindNormal('<leader>xx', ':wq<cr>')
BindNormal('<leader>xa', ':wqa<cr>')
BindNormal('<leader>v', ':lua Source_config()<cr>', { silent = true })
BindNormal('<leader>e', [[<Cmd>lua vim.diagnostic.open_float(0, {scope="line"})<cr>]], { silent = true })
BindNormal('<leader>f', ':Telescope find_files<cr>')
BindNormal('<leader>g', ':Telescope live_grep<cr>')
BindNormal('<leader>b', ':Telescope buffers<cr>')
BindNormal('<leader>r', ':Telescope resume<cr>')
BindNormal('<Esc>', ':nohl<cr>:match none<cr>')
BindNormal('<leader><Tab>', '<C-^>')
BindNormal('U', '<C-r>')
BindNormal('<leader>=', 'gg=G<C-o>zz')
BindNormal('<leader>il', ':e ~/dev/dotfiles/nvim/init.lua<cr>')
BindNormal('<leader>ip', ':e ~/dev/dotfiles/nvim/lua/plugins.lua<cr>')
BindNormal('<leader>ic', ':e ~/dev/dotfiles/nvim/lua/plugin_config<cr>')
BindNormal('<leader>pe', ':e ~/AppData/Local/nvim-data<cr>')
BindNormal('<leader>t', ':tabnew<cr>')
BindNormal('<leader>wh', '<C-w>h')
BindNormal('<leader>wj', '<C-w>j')
BindNormal('<leader>wk', '<C-w>k')
BindNormal('<leader>wl', '<C-w>l')
BindNormal('H', 'Hzz')
BindNormal('L', 'Lzz')
BindNormal('<leader>o', '<C-o>zz')
BindNormal('<s-cr>', ':a<cr><cr>.<cr>k')
BindNormal('<c-s-h>', ':lua DeleteNextLine()<CR>', { silent = true })
BindNormal('<bs>', 'dd')
BindNormal('<leader>yf', 'ggyG')
BindNormal('<leader>a', [[<cmd>lua vim.lsp.buf.code_action()<cr>]], { silent = true })
BindNormal('<leader>n', ':lua ToggleNetrw()<CR>', { silent = true })

BindNormal('<F5>', '', {
  callback = function()
    local handle
    handle = vim.loop.spawn('unison', { detached = true }, function(code)
      handle:close()
      if code == 0 then
        vim.schedule(function()
          vim.notify('Unison sync complete', vim.log.levels.INFO)
        end)
      else
        vim.schedule(function()
          vim.notify('Unison failed with code ' .. code, vim.log.levels.ERROR)
        end)
      end
    end)
  end,
  silent = true
})

BindNormal('<leader>-', ':lua InsertNoPush()<CR>', { silent = true })

-- Functions
function Source_config()
  vim.api.nvim_command('luafile ' .. vim.fn.stdpath('config') .. '/init.lua')
  vim.api.nvim_command('silent! doautocmd FileType')
end

function DeleteNextLine()
  local current_line = vim.api.nvim_win_get_cursor(0)[1]
  local current_col = vim.api.nvim_win_get_cursor(0)[2]
  vim.api.nvim_buf_set_lines(0, current_line, current_line + 1, false, {})
  vim.api.nvim_win_set_cursor(0, { current_line, current_col })
end

function ToggleNetrw()
  if vim.bo.filetype == 'netrw' then
    if vim.g.last_netrw_buf and vim.fn.bufexists(vim.g.last_netrw_buf) == 1 then
      vim.cmd('buffer ' .. vim.g.last_netrw_buf)
    else
      vim.cmd('bd')
    end
  else
    vim.g.last_netrw_buf = vim.fn.bufnr()
    vim.cmd('Ex')
  end
end

function InsertNoPush()
  local current_line = vim.fn.line('.')
  local current_indent = vim.fn.indent(current_line)
  local comment = string.rep(' ', current_indent) .. "// @nopush"
  vim.fn.append(current_line - 1, comment)
end
