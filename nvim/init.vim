" /////////////////////////////////////////
" Author: Jacob Nardone
" File:   init.vim
" Type:   Vimscript
" Desc:   Custom config file for Neovim.
" /////////////////////////////////////////

"-------------------------------------------------------------------------------------------------------------------------|
" PLUGIN REGISTRAR |
" _________________/

call plug#begin()

Plug 'nvim-lua/plenary.nvim'              " Telescope (below) depends on it
Plug 'nvim-telescope/telescope.nvim'      " Fuzzy file/grep project search tool

" JSX highlighting/indentation support
Plug 'maxmellon/vim-jsx-pretty'

" Context view + language highlighting support
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-treesitter/nvim-treesitter-context'

" Status line config
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-tree/nvim-web-devicons'

" Auto-pairing
Plug 'windwp/nvim-autopairs'

" Colorschemes
Plug 'EdenEast/nightfox.nvim'                            
Plug 'Mofiqul/vscode.nvim'
Plug 'neanias/everforest-nvim', { 'branch': 'main' }
 


call plug#end()
" filetype indent off   " Disable file-type-specific indentation
" syntax off            " Disable syntax highlighting



" Set the leader key
let mapleader = "\<Space>"


" Execute the lua config file
lua require('config')  -- Execute all Lua-based configuration
lua require('tabline') -- My custom behavior for naming tabs


colorscheme duskfox
set background=dark


set foldcolumn=0

set cursorline
set cursorcolumn
" Specify behavior of line/column HL for windows
augroup LineColumnHL
  autocmd!
  autocmd WinEnter * set cursorcolumn cursorline
  autocmd WinLeave * set nocursorcolumn nocursorline
augroup END


" Makes it so yanking copies to the system clipboard (side effect: makes pasting slower)
" Alternativaley, you can just use "+y to yank to system
"   and "+p to paste from system.
"set clipboard+=unnamedplus


set ts=3
set sw=3

" Convert tabs to spaces
set expandtab

set number relativenumber
set autoindent
set smartindent


" set indentation level for certin programming languages
autocmd FileType javascript,json,org,vim,lua setlocal sw=2 ts=2

" Auto save buffers on focus lost
autocmd FocusLost * :update


" NOTE: With 'ripgrep', Telescope automatically ignores
" searching anything in the .gitignore, BUT, .rgignore file
" in your root directory has priortity, and can be used to 
" 'ignore ignores' set in any .gitignore.

autocmd FileType TelescopePrompt setlocal nocursorline nocursorcolumn


"---------------|| Mappings || ---------------"
" Reload both the init.vim and config.lua
nnoremap <leader>s :source $MYVIMRC<cr>:luafile <C-R>=stdpath('config') . '/lua/config.lua'<cr><cr>

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
nnoremap <ESC> :nohl<cr>

" PlugInstall
nnoremap <leader>pi :PlugInstall<cr>
" PlugClean
nnoremap <leader>pc :PlugClean<cr>


" Open the previous buffer using leader -> TAB
nnoremap <leader><Tab> <C-^>

" Remapping of 'redo'
nnoremap U <C-r>

" Format entire file
nnoremap <leader>= gg=G<C-o>

" Change into current open file's directory
nnoremap <leader>cd :lcd %:p:h<cr>

" Kill all buffers
nnoremap <leader>ka :bufdo bd<cr>

" Open init.vim config file 
nnoremap <leader>iv :e ~/AppData/Local/nvim/init.vim<cr>
" Open config.lua config file 
nnoremap <leader>il :e ~/AppData/Local/nvim/lua/config.lua<cr>

" Open plugged folder (to quickly edit plugin files)
nnoremap <leader>pe :e ~/AppData/Local/nvim-data/plugged<cr>


" Set the cdpath so that I can easily cd into directories at this location
set cdpath+=~/dev/projects
set cdpath+=~/dev/intellimind

" Change into the (recent) project ive been working on (I need to update this
" manually here)
nnoremap <leader>ap :cd cvo_website<cr>

" Open a new tab
nnoremap <leader>t :tabnew<cr>
nnoremap <leader>kt :tabclose<cr>

" Moving between open tabs
nnoremap <leader>q gT
nnoremap <leader>w gt

" Center view on cursor after Shift-H/L
nnoremap <S-h> Hzz
nnoremap <S-l> Lzz

" Block comment
vnoremap <leader>/ :s#^#// <cr> :nohl<cr>



" Commands for opening common files/folders
command! DEV e ~/dev
command! WID e ~/dev/notes/personal/WID.org


" VERY IMPORTANT - stops extremely annoying 30 second freeze when executing
" 'SHIFT-K' (I often do by accident).
" .. issue explained here -> https://github.com/neovim/neovim/issues/21169
set keywordprg=:help

" Tells vim to see underscores as words
set iskeyword-=_


" Neovide config
if exists("g:neovide")
   " Put anything you want to happen only in Neovide here
  cd ~/dev

  set guifont=Cousine\ NFM:h15
  
  let g:neovide_cursor_vfx_mode = "pixiedust"

  let g:neovide_cursor_vfx_particle_density = 14.0
  let g:neovide_cursor_vfx_particle_lifetime = 1.4

  let g:neovide_cursor_animation_length = 0.02

  let g:neovide_hide_mouse_when_typing = v:true

  let g:neovide_refresh_rate = 120
  let g:neovide_refresh_rate_idle = 60
  "let g:neovide_refresh_rate = 60
  "let g:neovide_refresh_rate_idle = 5

  let g:neovide_fullscreen = v:true
endif


