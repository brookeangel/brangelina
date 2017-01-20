" # Global settings
filetype plugin indent on
runtime! macros/matchit.vim
syntax on

set backspace=2
set clipboard=unnamed
set completeopt+=longest
set completeopt-=preview
set cursorline
set encoding=utf-8
set expandtab
set hidden
set history=1000
set hlsearch
set inccommand=nosplit
set incsearch
set laststatus=2
set mouse=a
set nobackup
set noswapfile
set number
set omnifunc=syntaxcomplete#Complete
set scrolloff=1
set shell=/bin/bash                                             " required by gitgutter plugin
set shiftround
set shiftwidth=2
let &showbreak = '↪ '
set smarttab
set splitbelow
set splitright
set tabstop=2
set termguicolors
set ttyfast
set undodir=~/tmp/vim/undo
set undofile
set wildignorecase
set wildmenu
set wildmode=full

" # Plugins
call plug#begin('~/.vim/plugged')
Plug 'Shougo/deoplete.nvim'                                     " Code completion
Plug 'airblade/vim-gitgutter'                                   " Column with line changes
Plug 'bronson/vim-visual-star-search'                           " Easily search for the selected text
Plug 'editorconfig/editorconfig-vim'                            " Settings based on .editorconfig file
Plug 'elentok/todo.vim'                                         " Todo.txt support
Plug 'elmcast/elm-vim'                                          " Elm language syntac
Plug 'haya14busa/incsearch.vim'                                 " Improved incremental searching
Plug 'itchyny/lightline.vim'                                    " Status bar
Plug 'junegunn/fzf'                                             " Fuzzy file searching
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-sneak'                                       " Medium-range motion
Plug 'qpkorr/vim-bufkill'                                       " Kill a buffer without closing its window
Plug 'scrooloose/syntastic'                                     " Syntax checking
Plug 'sheerun/vim-polyglot'                                     " Combines a whole bunch of vim syntax packs
Plug 'stefandtw/quickfix-reflector.vim'                         " Make quickfix window editable
Plug 'tpope/vim-abolish'                                        " Working with variants of a world
Plug 'tpope/vim-commentary'                                     " (Un)commenting lines
Plug 'tpope/vim-eunuch'                                         " Unix commands
Plug 'tpope/vim-fugitive'                                       " GIT integration
Plug 'tpope/vim-jdaddy'                                         " JSON manipulation commands
Plug 'tpope/vim-repeat'                                         " Use dot operator with plugins
Plug 'tpope/vim-sleuth'                                         " Detect indent style from a file
Plug 'tpope/vim-speeddating'                                    " Manipulation of date strings
Plug 'tpope/vim-surround'                                       " Commands to work with surroundings
Plug 'tpope/vim-unimpaired'                                     " Miscellaneous commands
Plug 'vim-scripts/CursorLineCurrentWindow'                      " Only show the cursorline in the active window
Plug 'whatyouhide/vim-gotham'
call plug#end()

" # Plugin configuration
let g:deoplete#enable_at_startup = 1
let g:EditorConfig_exclude_patterns = ['.git/COMMIT_EDITMSG']
let g:elm_format_autosave = 1
let g:elm_make_show_warnings = 1
let g:elm_syntastic_show_warnings = 1
let g:fzf_layout = { 'window': 'enew' }
let g:lightline = { 'colorscheme': 'gotham' }
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['standard']
let g:syntastic_ruby_checkers = ['rubocop']
colorscheme gotham

" # Misc configuration
hi Comment cterm=italic

if !isdirectory(expand(&undodir))
   call mkdir(expand(&undodir), "p")
endif

function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction

" # Mappings
let mapleader=" "
let maplocalleader="\\"

xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

" Easy movement between windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Perform fuzzy file searching
nnoremap <C-P> :Files<CR>
nnoremap <C-B> :Buffers<CR>

" Hightlight all incremental search results
map /  <plug>(incsearch-forward)
map ?  <plug>(incsearch-backward)
map g/ <plug>(incsearch-stay)

" Terminal mappings
nnoremap <silent> <C-T> :Ttoggle<cr>
tnoremap <silent> <C-T> <C-\><C-n>:Ttoggle<cr>
tnoremap <C-[> <C-\><C-n>
tnoremap <C-O> <C-\><C-n><C-O><C-O>
tnoremap <C-J> <C-\><C-n><C-W><C-J>
tnoremap <C-K> <C-\><C-n><C-W><C-K>
tnoremap <C-L> <C-\><C-n><C-W><C-L>
tnoremap <C-H> <C-\><C-n><C-W><C-H>

" # Autocmds
augroup customCommands
  autocmd!
  autocmd FileType markdown nnoremap <localleader>m :LivedownToggle<cr>
  autocmd FileType javascript nnoremap <localleader>c :JSContextColorToggle<cr>
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile *.sjs set filetype=javascript
  autocmd FileType dirvish setlocal nonumber
  autocmd WinEnter term://* startinsert
  autocmd BufLeave *;#FZF silent! BD!
  " Sort files in buffer, but keep the cursor on the file we came from.
  autocmd FileType dirvish let b:dirvish['currentLine']=getline('.') |
    \ sort ir /^.*[^\/]$/ |
    \ keepjumps call search('\V\^'.escape(b:dirvish['currentLine'],'\').'\$', 'cw')
  autocmd BufWritePre * :%s/\s\+$//e  " automatically remove trailing whitespace on writing
augroup END