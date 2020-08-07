" Vim with all enhancements
"source $VIMRUNTIME/vimrc_example.vim

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction




set nocompatible              " be iMproved, required
"filetype off                  " required filetype plugin indent on

filetype plugin indent on
call plug#begin()

"Plugin 'Powerline/powerline', {'rtp': 'powerline/bindings/vim/'}
"Plugin 'morhetz/gruvbox'
"Plugin 'danilo-augusto/vim-afterglow'

Plug 'sjl/badwolf'
Plug 'preservim/nerdtree'
Plug 'chriskempson/base16-vim'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'xolox/vim-misc'
Plug 'vim-python/python-syntax'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'itchyny/lightline.vim'

call plug#end()            " required

"autocmd vimenter * NERDTree

:cd C:/dev

syntax on
set guifont=Inconsolata\ for\ Powerline:h12
set guioptions -=T
set guioptions-=L
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set renderoptions=type:directx,
    \gamma:1.5,contrast:0.5,geom:1,
    \renmode:5,taamode:1,level:0.5

"this doesnt work on gVim windows
"set term=xterm-256color

set termencoding=utf-8
"set guifont=Bitstream\ Vera\ Sans\ Mono:h14

set cursorline

"start gVim fullscreen (on Windows)
au GUIEnter * simalt ~x

if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
	set termguicolors
endif

let g:python_highlight_all = 1


"colorscheme base16-gruvbox-dark-pale
colorscheme base16-atelier-forest-light
set sw=3
set ts=3
set mouse=a
set laststatus=2
set number relativenumber
set autoindent
set smartindent
set backspace=indent,eol,start
"set undodir=C:/Program\ Files\ (x86)/Vim/undo-dir
set nobackup

"auto save when the focus on vim is lost
:au FocusLost * :wa
"set autowriteall

" turns off bell sounds
autocmd GUIEnter * set vb t_vb=

"mappings here
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

inoremap <S-Tab> <ESC>
"nnoremap <CR> o <ESC>
"nnoremap <BS> ddk

"python execution; expects a main.py
nnoremap <F5> :!clear <bar> python main.py <CR> <CR>
nnoremap <F3> :!ctags -R <CR> <CR>

" auto centering some basic commands
nnoremap <S-h> <S-h> zz
nnoremap <S-l> <S-l> zz
nnoremap <C-]> <C-]> zz

"comment out
nmap <F2> <S-i>//<S-Tab>
"uncomment
nmap <F1> <S-i><S-Tab>lxx

"inoremap <S-r> <Esc>
""C++ compilation and execution
"nnoremap <F6> !clear &&

set tags=tags

"start Nerdtree
autocmd VimEnter * NERDTree

