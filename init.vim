" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
"
call plug#begin()

Plug 'nvim-lua/plenary.nvim'                             " Telescope (below) depends on it
Plug 'nvim-telescope/telescope.nvim'                     " Fuzzy file/grep project search tool
Plug 'maxmellon/vim-jsx-pretty'                          " JSX highlighting/indentation support
Plug 'EdenEast/nightfox.nvim'                            " Colorschemes

Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-context'

Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'

Plug 'Mofiqul/vscode.nvim'
Plug 'karb94/neoscroll.nvim'

call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting



colorscheme vscode


set foldcolumn=1

" Makes it so yanking copies to the system clipboard (side effect: makes pasting slower)
" Alternativaley, you can just use "+y to yank to system
"   and "+p to paste from system.
"set clipboard+=unnamedplus


set ts=3
set sw=3

" Convert tabs to spaces
set expandtab

set autoindent
set smartindent

" set indentation level for different programming languages
autocmd FileType javascript,json,vim,org setlocal sw=2 ts=2
autocmd FileType c,cpp setlocal sw=3 ts=3


" Auto save buffers on focus lost
autocmd FocusLost * :update


" NOTE: With 'ripgrep', Telescope appears to automatically ignore
" searching anything in the .gitignore.


"---------------|| Mappings || ---------------"
" Set the leader key to 'space'
let mapleader = "\<Space>"

""" Custom Telescope mappings:
" Find files using Telescope command-line sugar.
nnoremap <leader>f :Telescope find_files<cr>
" Below command is for project string search
nnoremap <leader>g :Telescope live_grep<cr>
" Below command is for open-buffer switching
nnoremap <leader>b :Telescope buffers<cr>
" Below command is for reopening telescope in its previous state (retains your
"   search queries).
nnoremap <leader>r :Telescope resume<cr>

" Not sure what this is for yet; haven't used it
nnoremap <leader>h :Telescope help_tags<cr>

" Remove the current highlighted words (like after a / search)
nnoremap <leader>hl :nohl<cr>

" PlugInstall
nnoremap <leader>pi :PlugInstall<cr>
" PlugClean
nnoremap <leader>pc :PlugClean<cr>


" Open the previous buffer using leader -> TAB
nnoremap <leader><Tab> <C-^>

" Format entire file
nnoremap <leader>= gg=G<C-o>

" Change into current open file's directory
nnoremap <leader>cd :lcd %:p:h<CR>

" Kill all buffers
nnoremap <leader>ka :bufdo bd<CR>

" Open init.vim config file 
nnoremap <leader>i :e ~/AppData/Local/nvim/init.vim<CR>

" Center view on cursor after Shift-H/L
nnoremap <S-h> Hzz
nnoremap <S-l> Lzz

" Block comment
vnoremap <leader>/ :s#^#// <CR> :nohl<CR>



" Open my WID file
command! WID e ~/dev/notes/personal/WID.org

" Reload init.vim
command! SRC source $MYVIMRC



" VERY IMPORTANT - stops extremely annoying 30 second freeze when executing
" 'SHIFT-K' (I often do by accident).
" .. issue explained here -> https://github.com/neovim/neovim/issues/21169
set keywordprg=:help

" Tells vim to see underscores as words
set iskeyword-=_


" Neovide config
if exists("g:neovide")
  " Put anything you want to happen only in Neovide here

  cd C:\Users\jacob.nardone\dev

  set guifont=Cousine\ NFM:h14

  let g:neovide_cursor_vfx_mode = "pixiedust"

  let g:neovide_cursor_vfx_particle_density = 14.0
  let g:neovide_cursor_vfx_particle_lifetime = 1.4

  let g:neovide_cursor_animation_length = 0.02

  let g:neovide_hide_mouse_when_typing = v:true

  let g:neovide_refresh_rate = 60
  let g:neovide_refresh_rate_idle = 5

  let g:neovide_fullscreen = v:true

endif



lua << END

-- Treesitter config
require('nvim-treesitter.configs').setup {
  ensure_installed = {'javascript', 'html', 'css', 'vim', 'lua', 'cpp', 'rust'},
  highlight = {
    enable = true,
  },
}
require('treesitter-context').setup{
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 2, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
  trim_scope = 'inner', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
}


-- Telescope config
require('telescope').setup{
  defaults = {
    mappings = {
      n = { -- Normal mode mappings
        ['<c-d>'] = require('telescope.actions').delete_buffer
      },
    },
    ripgrep_arguments = {
      'rg',
      '--hidden',
      '-ignore-file', (os.getenv('USERPROFILE') or os.getenv('HOME')) .. '/.rgignore',
    },
  },
}


-- Lualine config
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'Tomorrow',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {{'filename', path = 1}},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {{'filename', path = 1}},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}


-- Smooth scroll
-- require('neoscroll').setup {
  -- easing_function = "circular"
--}

END


