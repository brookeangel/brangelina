" Five steps to get started:

" (1) Copy this file to ~/.config/nvim/init.vim

" (2) Replace this with a path to brangelina on your machine.
source ~/dotfiles/brangelina/brangelina.vim

call plug#begin('~/.vim/plugged')
  call BrangelinaPlugins()
  " (3) Add your custom plugins below.
  Plug 'iCyMind/NeoSolarized'
  Plug 'rking/ag'
  Plug 'itchyny/lightline.vim'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'ElmCast/elm-vim'
call plug#end()

" (4) Configure the theme you want to use below.
colorscheme NeoSolarized
let g:lightline = { 'colorscheme': 'solarized' }
set background=dark
let g:neoterm_shell = 'zsh'

" (5) Enjoy using branglina.vim. Issues and pull requests are welcome!
