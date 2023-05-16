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


  Plug 'glepnir/dashboard-nvim'             " Customizable splash screen

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

  " Nvim-tree
  Plug 'nvim-tree/nvim-tree.lua'

  " Auto-pairing
  Plug 'cohama/lexima.vim'


  " Colorschemes
  Plug 'xjtn18/nightfox.nvim'                 " My fork of NightFox
  Plug 'neanias/everforest-nvim', { 'branch': 'main' }
  Plug 'UnikMask/iroh-vim'


call plug#end()
filetype indent off   " Disable file-type-specific indentation
" syntax off            " Disable syntax highlighting


" Set the leader key
let mapleader = "\<Space>"

set background=dark

" Execute the lua config file
lua require('config')  -- Execute my Lua config file

source ~/AppData/Local/nvim/tabline.vim

set foldcolumn=0

" Specify behavior of line/column HL for windows
augroup LineColumnHL
autocmd!
autocmd WinEnter * set cursorcolumn cursorline
autocmd WinLeave * set nocursorcolumn nocursorline
augroup END

" Save folds information for my config files
augroup SaveFolds
autocmd!
autocmd BufWinLeave *.vim,*.lua mkview
autocmd BufWinEnter *.vim,*.lua silent! loadview
augroup END


set ts=3
set sw=3

" Convert tabs to spaces
set expandtab

set number relativenumber
set autoindent
set smartindent

set ignorecase
set smartcase

" VERY IMPORTANT - stops extremely annoying 30 second freeze when executing
" 'SHIFT-K' (I often do by accident).
" .. issue explained here -> https://github.com/neovim/neovim/issues/21169
set keywordprg=:help

" Tells vim to see underscores as words
set iskeyword-=_


" Set the cdpath so that I can easily cd into directories at this location
set cdpath+=~/dev/projects
set cdpath+=~/dev/intellimind


" set indentation level for certin programming languages
autocmd FileType javascript,json,org,vim,lua setlocal sw=2 ts=2

autocmd FileType rust,c,cpp,python setlocal sw=3 ts=3

" Auto save buffers on focus lost
autocmd FocusLost * :update

" Disable line/column HL in Telescope prompt
autocmd FileType TelescopePrompt setlocal nocursorline nocursorcolumn


"---------------|| Mappings || ---------------"

nnoremap <silent> <leader>s :lua source_config()<cr>

" Open nvim-tree (file explorer)
nnoremap <leader>e :NvimTreeFindFileToggle<cr>zz

""" TELESCOPE MAPPINGS
nnoremap <leader>f :Telescope find_files<cr>
nnoremap <leader>g :Telescope live_grep<cr>
nnoremap <leader>b :Telescope buffers<cr>
nnoremap <leader>r :Telescope resume<cr>
" nnoremap <leader>h :Telescope help_tags<cr>

" Remove the current highlighted words (like after a / search)
nnoremap <ESC> :nohl<cr>


" Open the previous buffer using leader -> TAB
nnoremap <leader><Tab> <C-^>

" Remapping of 'redo'
nnoremap U <C-r>

" Format entire file
nnoremap <leader>= gg=G<C-o>zz


" Open init.vim config file 
nnoremap <leader>iv :e ~/AppData/Local/nvim/init.vim<cr>
" Open config.lua config file 
nnoremap <leader>il :e ~/AppData/Local/nvim/lua/config.lua<cr>

" Open plugged folder (to quickly edit plugin files)
nnoremap <leader>pe :e ~/AppData/Local/nvim-data/plugged<cr>


" Open a new tab
nnoremap <leader>t :tabnew<cr>
nnoremap <leader>kt :tabclose<cr>

" Moving between open tabs
"nnoremap <leader>q gT
"nnoremap <leader>w gt

" Moving between windows
nnoremap <leader>wh <C-w>h
nnoremap <leader>wj <C-w>j
nnoremap <leader>wk <C-w>k
nnoremap <leader>wl <C-w>l

" Center view on cursor after Shift-H/L
nnoremap H Hzz
nnoremap L Lzz

" Center view on cursor after C-o
nnoremap <leader>o <C-o>zz

" Center view on 'next', forward and back
nnoremap n nzz
nnoremap N Nzz

" Block comment
vnoremap <leader>/ :s#^#// <cr> :nohl<cr>


"---------------|| Commands || ---------------"
" Commands for opening common files/folders
command! DEV e ~/dev
command! PLAY e ~/dev/playground
command! WID e ~/dev/notes/personal/WID.org
command! ALAC e ~/AppData/Roaming/alacritty/alacritty.yml

" Change into current open file's directory
command! CD lcd %:p:h

" Kill all buffers
command! KA bufdo bd

" PlugInstall
command! PI PlugInstall
" PlugClean
command! PC PlugClean

" Change into the (recent) project ive been working on (I need to update this manually here)
command! AP cd cvo_website

" Return to dashboard
command! D Dashboard



