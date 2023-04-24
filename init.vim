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

" Colorschemes
Plug 'EdenEast/nightfox.nvim'                            
Plug 'Mofiqul/vscode.nvim'
Plug 'neanias/everforest-nvim', { 'branch': 'main' }


call plug#end()
" You can revert the settings after the call like so:
"   filetype indent off   " Disable file-type-specific indentation
"   syntax off            " Disable syntax highlighting




colorscheme everforest
set background=light


set foldcolumn=0
set cursorline


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
nnoremap <ESC> :nohl<cr>

" PlugInstall
nnoremap <leader>pi :PlugInstall<cr>
" PlugClean
nnoremap <leader>pc :PlugClean<cr>


" Open the previous buffer using leader -> TAB
nnoremap <leader><Tab> <C-^>

" Format entire file
nnoremap <leader>= gg=G<C-o>

" Change into current open file's directory
nnoremap <leader>cd :lcd %:p:h<cr>

" Kill all buffers
nnoremap <leader>ka :bufdo bd<cr>

" Open init.vim config file 
nnoremap <leader>i :e ~/AppData/Local/nvim/init.vim<cr>

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



" Open my WID file
command! WID e ~/dev/notes/personal/WID.org

" Reload init.vim
command! SRC source $MYVIMRC


" Configuring the naming behavior of tabs
set tabline=%!GetTabLine()

function! GetTabLine()
  let tabs = BuildTabs()
  let line = ''
  for i in range(len(tabs))
    let line .= (i+1 == tabpagenr()) ? '%#TabLineSel#' : '%#TabLine#'
    let line .= '%' . (i + 1) . 'T'
    let line .= ' ' . tabs[i].uniq_name . ' '
  endfor
  let line .= '%#TabLineFill#%T'
  return line
endfunction

function! BuildTabs()
  let tabs = []
  for i in range(tabpagenr('$'))
    let tabnum = i + 1
    let buflist = tabpagebuflist(tabnum)
    let file_path = ''
    let tab_name = bufname(buflist[0])
    if tab_name =~ 'NERD_tree' && len(buflist) > 1
      let tab_name = bufname(buflist[1])
    end
    let is_custom_name = 0
    if tab_name == ''
      let tab_name = '[No Name]'
      let is_custom_name = 1
    elseif tab_name =~ 'fzf'
      let tab_name = 'FZF'
      let is_custom_name = 1
    else
      let file_path = fnamemodify(tab_name, ':p')
      let tab_name = fnamemodify(tab_name, ':p:t')
    end
    let tab = {
      \ 'name': tab_name,
      \ 'uniq_name': tab_name,
      \ 'file_path': file_path,
      \ 'is_custom_name': is_custom_name
      \ }
    call add(tabs, tab)
  endfor
  call CalculateTabUniqueNames(tabs)
  return tabs
endfunction

function! CalculateTabUniqueNames(tabs)
  for tab in a:tabs
    if tab.is_custom_name | continue | endif
    let tab_common_path = ''
    for other_tab in a:tabs
      if tab.name != other_tab.name || tab.file_path == other_tab.file_path
        \ || other_tab.is_custom_name
        continue
      endif
      let common_path = GetCommonPath(tab.file_path, other_tab.file_path)
      if tab_common_path == '' || len(common_path) < len(tab_common_path)
        let tab_common_path = common_path
      endif
    endfor
    if tab_common_path == '' | continue | endif
    let common_path_has_immediate_child = 0
    for other_tab in a:tabs
      if tab.name == other_tab.name && !other_tab.is_custom_name
        \ && tab_common_path == fnamemodify(other_tab.file_path, ':h')
        let common_path_has_immediate_child = 1
        break
      endif
    endfor
    if common_path_has_immediate_child
      let tab_common_path = fnamemodify(common_path, ':h')
    endif
    let tab.uniq_name = fnamemodify(tab.file_path, ':h:t')
  endfor
endfunction

function! GetCommonPath(path1, path2)
  let dirs1 = split(a:path1, '/', 1)
  let dirs2 = split(a:path2, '/', 1)
  let i_different = 0
  for i in range(len(dirs1))
    if get(dirs1, i) != get(dirs2, i)
      let i_different = i
      break
    endif
  endfor
  return join(dirs1[0:i_different-1], '/')
endfunction

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


-- Add the tab switching commands for each number key
for i = 1, 9 do
  vim.api.nvim_set_keymap('n', '<leader>' .. i, ':tabn ' .. i .. '<CR>', { noremap = true, silent = true })
end


-- Treesitter config
require('nvim-treesitter.configs').setup {
  ensure_installed = {'javascript', 'html', 'css', 'vim', 'lua', 'rust', 'cpp'},
  highlight = {
    enable = true,
  },
  indent = {
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

--[[
My original baseline lualine config

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'wombat',
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
--]]


-- Slanted gaps preset theme (from Lualine github)

local colors = {
  red = '#FF6060',
  grey = '#a0a1a7',
  --black = '#383a42',
  black = '#57B6F3',
  white = '#fffbef',
  --idk = '#8BD1FE',
  --idk = '#57B6F3',
  idk = '#C9B79A',
  light_green = '#83a598',
  orange = '#fe8019',
  --green = '#8ec07c',
  green = '#73C22F',
}

local theme = {
   normal = {
      a = { fg = colors.white, bg = colors.black },
      b = { fg = colors.white, bg = colors.grey },
      c = { fg = colors.black, bg = colors.idk },
      z = { fg = colors.white, bg = colors.black },
   },
   insert = {
      a = { fg = colors.white, bg = colors.green },
      --c = { fg = colors.black, bg = colors.green },
   },
   visual = {
      a = { fg = colors.white, bg = colors.orange },
      --c = { fg = colors.black, bg = colors.orange },
   },
   replace = {
      a = { fg = colors.white, bg = colors.light_green }
   },
}

local empty = require('lualine.component'):extend()
function empty:draw(default_highlight)
  self.status = ''
  self.applied_separator = ''
  self:apply_highlights(default_highlight)
  self:apply_section_separators()
  return self.status
end

-- Put proper separators and gaps between components in sections
local function process_sections(sections)
  for name, section in pairs(sections) do
    local left = name:sub(9, 10) < 'x'
    for pos = 1, name ~= 'lualine_z' and #section or #section - 1 do
      table.insert(section, pos * 2, { empty, color = { fg = colors.white, bg = colors.white } })
    end
    for id, comp in ipairs(section) do
      if type(comp) ~= 'table' then
        comp = { comp }
        section[id] = comp
      end
      comp.separator = left and { right = '' } or { left = '' }
    end
  end
  return sections
end

local function search_result()
  if vim.v.hlsearch == 0 then
    return ''
  end
  local last_search = vim.fn.getreg('/')
  if not last_search or last_search == '' then
    return ''
  end
  local searchcount = vim.fn.searchcount { maxcount = 9999 }
  return last_search .. '(' .. searchcount.current .. '/' .. searchcount.total .. ')'
end

local function modified()
  if vim.bo.modified then
    return '+'
  elseif vim.bo.modifiable == false or vim.bo.readonly == true then
    return '-'
  end
  return ''
end

require('lualine').setup {
  options = {
    theme = theme,
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = process_sections {
    lualine_a = { 'mode' },
    lualine_b = {
      'branch',
      --'diff', -- THIS ADDS THE DIFF SECTION OF THE STATUS LINE
      {
        'diagnostics',
        source = { 'nvim' },
        sections = { 'error' },
        diagnostics_color = { error = { bg = colors.red, fg = colors.white } },
      },
      {
        'diagnostics',
        source = { 'nvim' },
        sections = { 'warn' },
        diagnostics_color = { warn = { bg = colors.orange, fg = colors.white } },
      },
      { 'filename', file_status = false, path = 1 },
      { modified, color = { bg = colors.red } },
      {
        '%w',
        cond = function()
          return vim.wo.previewwindow
        end,
      },
      {
        '%r',
        cond = function()
          return vim.bo.readonly
        end,
      },
      {
        '%q',
        cond = function()
          return vim.bo.buftype == 'quickfix'
        end,
      },
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { search_result, 'filetype' },
    lualine_z = { '%l:%c', '%p%%/%L' },
  },
  inactive_sections = {
    lualine_c = { '%f %y %m' },
    lualine_x = {},
  },
}
