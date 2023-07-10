require('core.keybinds')
require('core.commands')
require('core.plugins')
require('core.plugin_config')


-- Set the colorscheme
--vim.cmd('colorscheme terafox')
vim.cmd('colorscheme habamax')


-- Makes it so that vim and system share the same clipboard
vim.api.nvim_set_option("clipboard","unnamed")


vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')


-- Run the tab-naming config file
vim.cmd('source ' .. vim.fn.expand('$HOME') .. '/AppData/Local/nvim/vimscript/tabline.vim')


-- Specify behavior of line/column HL for windows
vim.cmd [[
augroup LineColumnHL
autocmd!
"autocmd WinEnter * set cursorcolumn cursorline
"autocmd WinLeave * set nocursorcolumn nocursorline
augroup END
]]

-- Save folds information for my config files
vim.cmd [[
augroup SaveFolds
autocmd!
autocmd BufWinLeave *.vim,*.lua mkview
autocmd BufWinEnter *.vim,*.lua silent! loadview
augroup END
]]

-- Other settings
vim.opt.background = 'dark'
vim.opt.foldcolumn = '0'

vim.opt.tabstop = 3
vim.opt.shiftwidth = 3

-- Convert tabs to spaces
vim.opt.expandtab = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

-- VERY IMPORTANT - stops extremely annoying 30 second freeze when executing
-- 'SHIFT-K' (I often do by accident).
-- .. issue explained here -> https://github.com/neovim/neovim/issues/21169
vim.opt.keywordprg = ':help'

-- Tells vim to see underscores as words
--vim.opt.iskeyword:remove{'_'}

-- Set the cdpath so that I can easily cd into directories at this location
vim.opt.cdpath:append{
  vim.fn.expand('$HOME') .. '/dev/projects',
  vim.fn.expand('$HOME') .. '/dev/intellimind',
}

-- Auto save buffers on focus lost
vim.cmd('autocmd FocusLost * :update')

-- Disable line/column HL in Telescope prompt
vim.cmd('autocmd FileType TelescopePrompt setlocal nocursorline nocursorcolumn')

-- set indentation level for certain programming languages
vim.cmd('autocmd FileType javascript,javascriptreact,typescript,typescriptreact,json,org,vim,lua setlocal sw=2 ts=2')
vim.cmd('autocmd FileType rust,c,cpp setlocal sw=3 ts=3')
vim.cmd('autocmd FileType python setlocal sw=4 ts=4')



local function config_common()
  vim.cmd("cd ~/dev")
  if vim.g.neovide then
    vim.g.neovide_hide_mouse_when_typing = true
  end
end


local function config_home()
  --vim.opt.guifont = "Cousine NFM:h17"
  vim.opt.guifont = "BlexMono Nerd Font Mono:h16"
  --vim.cmd('set linespace=-2') -- Reduce the space between lines

  if vim.g.neovide then
    vim.g.neovide_cursor_vfx_mode = "pixiedust"

    vim.g.neovide_cursor_vfx_particle_density = 10.0
    vim.g.neovide_cursor_vfx_particle_lifetime = 3.0
    vim.g.neovide_cursor_animation_length = 0.02

    vim.g.neovide_refresh_rate = 120
    vim.g.neovide_refresh_rate_idle = 60
  end
end


local function config_work()
  --vim.opt.guifont = "Cousine NFM:h13"
  vim.opt.guifont = "BlexMono Nerd Font Mono:h13"
  --vim.cmd('set linespace=-1') -- Reduce the space between lines

  if vim.g.neovide then
    vim.g.neovide_cursor_vfx_mode = ""
    vim.g.neovide_cursor_animation_length = 0

    vim.g.neovide_refresh_rate = 30
    vim.g.neovide_refresh_rate_idle = 30
  end
end


config_home()
--config_work()

config_common()
