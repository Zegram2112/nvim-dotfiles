" DEPENDENCIES
" - Neovim
" - Vim-plug
" - Node.js
" - Python modules
"   * pynvim
"   * jedi
" - Fzf
"
" SYSTEM DEPENDENCIES
" Linux
" - xclip (For clipboard to work)
" 
" A NERD compatible font is needed for icons to work
"
" = Vim-plug plugins =
call plug#begin(stdpath('data').'/plugged')

" Sensible conventions
Plug 'jeffkreeftmeijer/neovim-sensible'
" Vscode-like intellisense
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" NERDTree file exploration
Plug 'scrooloose/nerdTree'
" Emmet for vim
Plug 'mattn/emmet-vim'
" Multiple language support
Plug 'sheerun/vim-polyglot'
" Fancy start screen
Plug 'mhinz/vim-startify'
" Git gutter
Plug 'airblade/vim-gitgutter'
" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Colorschemes
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'arcticicestudio/nord-vim'
Plug 'drewtempelmeyer/palenight.vim'
" Airline bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" NERDTree icons
Plug 'ryanoasis/vim-devicons'
" NERDTree icons highlight
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

call plug#end()

" = Visual configs =
" colorscheme onehalfdark
" colorscheme onehalflight
" colorscheme palenight
colorscheme nord
if (has("termguicolors"))
  set termguicolors
endif

" = Plugin configs =
" Emmet
let g:user_emmet_settings = {
\  'javascript': {
\    'extends': 'jsx',
\  },
\  'javascript.jsx': {
\    'extends': 'jsx',
\  },
\}
let g:user_emmet_leader_key='<C-Z>'

" = General configs =
set updatetime=100
set encoding=UTF-8
" set more natural split opening
set splitbelow
set splitright

" = Shortcuts =
" Easy navigation through shortcuts
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Map <Esc> to exit terminal-mode
tnoremap <Esc> <C-\><C-n>
nnoremap <C-n> :NERDTreeToggle<CR>
" Splits and tabs
nnoremap <leader>s :split<CR>
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>t :tabnew<CR>
" search files with <C-f>
nnoremap <C-f> :Files<CR>
