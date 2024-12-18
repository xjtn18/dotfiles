local where = os.getenv("WHERE") -- Determine where im at (custom env var that I need to define).

require('keybinds')
require('commands')
require('plugins')
require('plugin_config')
require('keep_session')
require('run_file')
--require('custom_search_functionality')

-- Platform-dependent constants
--local opsys = (package.config:sub(1,1) == '\\') and 'win' or 'unix'
--local home = (opsys == 'win') and os.getenv('USERPROFILE') or '~'

-- Makes it so that vim and system share the same clipboard
vim.api.nvim_set_option("clipboard", "unnamedplus")

vim.cmd('filetype on')
vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')

-- Set the colorscheme
--vim.cmd('colorscheme habamax')
vim.cmd('colorscheme catppuccin-frappe')

-- Set custom tab-naming behavior
vim.cmd('source ' .. vim.fn.stdpath('config') .. '/tabline.vim')

vim.opt.cursorline = true
vim.opt.cursorcolumn = true

-- Save folds information for my config files
vim.cmd [[
augroup SaveFolds
autocmd!
autocmd BufWinLeave *.vim,*.lua mkview
autocmd BufWinEnter *.vim,*.lua silent! loadview
augroup END
]]

vim.g.lexima_enable_newline_rules = 1
vim.g.lexima_enable_basic_rules = 0

local function paste()
  return {
    vim.fn.split(vim.fn.getreg(""), "\n"),
    vim.fn.getregtype(""),
  }
end

if vim.env.SSH_CONNECTION then
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },
    paste = {
      ["+"] = paste,
      ["*"] = paste,
    },
  }
end

-- Configure override of the "/" search functionality to refrain from Neovims default behavior of jumping to the first match.

-- Other settings
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

vim.opt.mouse = 'a'

vim.o.wildignorecase = true

-- VERY IMPORTANT - stops extremely annoying 30 second freeze when executing
-- 'SHIFT-K' (I often do by accident).
-- .. issue explained here -> https://github.com/neovim/neovim/issues/21169
vim.opt.keywordprg = ':help'

-- Tells vim to see underscores as words
--vim.opt.iskeyword:remove{'_'}

-- Set the cdpath so that I can easily cd into directories at this location
vim.opt.cdpath:append {
  '~/dev/projects',
  '~/dev/intellimind',
}

-- Disable auto-comment
vim.cmd([[autocmd FileType * set formatoptions-=ro]])

-- Disable line/column HL in Telescope prompt
vim.cmd('autocmd FileType TelescopePrompt setlocal nocursorline nocursorcolumn')

vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- set indentation level for certain programming languages
vim.cmd(
  'autocmd FileType javascript,javascriptreact,typescript,typescriptreact,json,vim,lua setlocal shiftwidth=2 tabstop=2')
vim.cmd('autocmd FileType c,cpp setlocal shiftwidth=3 tabstop=3')

if where == "home" then
  vim.opt.guifont = "BerkeleyMonoTrial Nerd Font:h16"
elseif where == "work" then
  vim.cmd('cd ~/dev/projects/cvo_website')
  vim.opt.guifont = "BerkeleyMonoTrial Nerd Font:h11"
else
  -- Assume then that we are running on the work linux EC2 instance
end
