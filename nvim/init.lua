local where = os.getenv("WHERE") -- Determine where im at (custom env var that I need to define).

require('keybinds')
require('commands')
require('plugins')
require('plugin_config')
require('keep_session')

-- Platform-dependent constants
--local opsys = (package.config:sub(1,1) == '\\') and 'win' or 'unix'
--local home = (opsys == 'win') and os.getenv('USERPROFILE') or '~'

-- Makes it so that vim and system share the same clipboard
vim.api.nvim_set_option("clipboard", "unnamed")

vim.cmd('filetype on')
vim.cmd('filetype plugin indent on')
vim.cmd('syntax on')

-- Set the colorscheme
--vim.cmd('colorscheme terafox')
vim.cmd('colorscheme habamax')

-- Set custom tab-naming behavior
vim.cmd('source ' .. vim.fn.stdpath('config') .. '/tabline.vim')

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

-- Auto save buffers on focus lost
vim.cmd('autocmd FocusLost * :update')

-- Disable auto-comment
vim.cmd([[autocmd FileType * set formatoptions-=ro]])

-- Disable line/column HL in Telescope prompt
vim.cmd('autocmd FileType TelescopePrompt setlocal nocursorline nocursorcolumn')

-- set indentation level for certain programming languages
vim.cmd(
    'autocmd FileType javascript,javascriptreact,typescript,typescriptreact,json,vim,lua setlocal shiftwidth=2 tabstop=2')
vim.cmd('autocmd FileType c,cpp setlocal shiftwidth=3 tabstop=3')

-- Auto-commands
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead", "FileType" }, {
    pattern = "*",
    callback = function()
        vim.o.tabstop = 4
        vim.o.shiftwidth = 4
    end,
})

if where == "home" then
    vim.opt.guifont = "BerkeleyMonoTrial Nerd Font:h16" -- FOR NON-CLI ONLY
elseif where == "work" then
    vim.cmd('cd ~/dev/projects/cvo_website')
    vim.opt.guifont = "BerkeleyMonoTrial Nerd Font:h11" -- FOR NON-CLI ONLY
else
    -- Assume then that we are running on the work linux EC2 instance
end
