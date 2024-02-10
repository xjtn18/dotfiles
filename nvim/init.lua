require('core.keybinds')
require('core.commands')
require('core.plugins')
require('core.plugin_config')

-- Platform-dependent constants
--local opsys = (package.config:sub(1,1) == '\\') and 'win' or 'unix'
--local home = (opsys == 'win') and os.getenv('USERPROFILE') or '~'

-- Set the colorscheme
vim.cmd('colorscheme terafox')

-- Makes it so that vim and system share the same clipboard
vim.api.nvim_set_option("clipboard","unnamed")


vim.cmd('filetype on')
vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')


-- Set custom tab-naming behavior
vim.cmd('source ' .. vim.fn.stdpath('config') .. '/vimscript/tabline.vim')

-- Specify behavior of line/column HL for windows
vim.cmd [[
augroup LineColumnHL
autocmd!
autocmd WinEnter * set cursorcolumn cursorline
autocmd WinLeave * set nocursorcolumn nocursorline
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

vim.g.lexima_enable_newline_rules = 1
vim.g.lexima_enable_basic_rules = 1

-- Other settings
vim.opt.background = 'dark'
vim.opt.foldcolumn = '0'

-- Convert tabs to spaces
vim.opt.expandtab = true

vim.opt.signcolumn = 'yes'
vim.opt.number = true
vim.opt.relativenumber = true
--vim.opt.autoindent = true
--vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- VERY IMPORTANT - stops extremely annoying 30 second freeze when executing
-- 'SHIFT-K' (I often do by accident).
-- .. issue explained here -> https://github.com/neovim/neovim/issues/21169
vim.opt.keywordprg = ':help'

-- Tells vim to see underscores as words
--vim.opt.iskeyword:remove{'_'}

-- Set the cdpath so that I can easily cd into directories at this location
vim.opt.cdpath:append{
  '~/dev/projects',
  '~/dev/intellimind',
}

-- Auto save buffers on focus lost
vim.cmd('autocmd FocusLost * :update')

-- Disable auto-comment
vim.cmd([[autocmd FileType * set formatoptions-=ro]])

-- Disable line/column HL in Telescope prompt
vim.cmd('autocmd FileType TelescopePrompt setlocal nocursorline nocursorcolumn')

-- set indentation level for certain programming languages
vim.cmd('autocmd FileType javascript,javascriptreact,typescript,typescriptreact,json,org,vim,lua setlocal sw=2 ts=2')
vim.cmd('autocmd FileType rust,c,cpp setlocal sw=3 ts=3')
vim.cmd('autocmd FileType python setlocal sw=4 ts=4')

local function config_home()
  vim.cmd('cd ~/dev')
  --vim.opt.guifont = "BlexMono Nerd Font Mono:h16"
  --vim.opt.guifont = "Berkeley Mono Trial:h16"
  --vim.cmd('set linespace=-2') -- Reduce the space between lines
end


local function config_work()
  vim.cmd('cd ~/dev/projects/cvo_website')
  --vim.opt.guifont = "Cousine NFM:h13"
  --vim.opt.guifont = "BlexMono Nerd Font Mono:h13"
  --vim.cmd('set linespace=-1') -- Reduce the space between lines
end

local function config_linux_ec2()
  vim.cmd('cd ~/dev')
end

local where = os.getenv("WHERE") -- Determine where im at (custom env var that I need to define).

if where == "home" then
  config_home()
elseif where == "work" then
  config_work()
else
  config_linux_ec2()
end
