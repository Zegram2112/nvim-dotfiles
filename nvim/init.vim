" DEPENDENCIES
" - Neovim
" - Vim-plug (auto-installed)
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
" INSTRUCTIONS
" 1. :PlugInstall
" 2. :CHADdeps
" 3. :COQdeps
" 4. install desired language servers
"

" = Auto Install =
" Vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
	  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif

" = Vim-plug plugins =
call plug#begin(stdpath('data').'/plugged')

" Sensible conventions
Plug 'jeffkreeftmeijer/neovim-sensible'
" Vscode-like intellisense
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
Plug 'neovim/nvim-lspconfig'
" CHADTree file exploration
if executable('python3')
   Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
else
   Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python -m chadtree deps'}
endif
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
Plug 'dracula/vim'
" Colorize color codes
Plug 'etdev/vim-hexcolor'
" Airline bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" NERDTree icons
Plug 'ryanoasis/vim-devicons'
" NERDTree icons highlight
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Clojure
Plug 'Olical/conjure'
" Conjure support - jack-in with nrepl dependencies
Plug 'tpope/vim-dispatch'
Plug 'clojure-vim/vim-jack-in'
Plug 'radenling/vim-dispatch-neovim'
" Structural editing for lisp languages
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
" Auto-close parens
Plug 'jiangmiao/auto-pairs'


call plug#end()

" = Visual configs =
" colorscheme onehalfdark
" colorscheme onehalflight
" colorscheme palenight
" colorscheme nord
colorscheme dracula
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

" LSP and COQ Config
lua << EOF
local lsp = require('lspconfig')
local coq = require('coq')

-- npm install -g pyright
lsp.pyright.setup{}

-- npm install -g vim-language-server
lsp.vimls.setup{}

-- npm install -g typescript typescript-language-server
lsp.tsserver.setup{
  filetypes = { "typescript", "typescriptreact", "typescript.tsx" }
}

-- npm install -g svelte-language-server
lsp.svelte.setup{}

-- npm install -g @tailwindcss/language-server
lsp.tailwindcss.setup{}

-- windows: choco install haskell-language-server
-- macos:   brew install haskell-language-server
-- arch:    sudo pacman -S haskell-language-server
lsp.hls.setup{}

-- windows: scoop install clojure-lsp
-- macos:   brew install clojure-lsp/brew/clojure-lsp-native
-- arch:    yay -S clojure-lsp-bin
lsp.clojure_lsp.setup{}
EOF

" = General configs =
set updatetime=100
set encoding=UTF-8
" set more natural split opening
set splitbelow
set splitright
" shell 
if has ('win32')
  let &shell = 'powershell'
  let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
  let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
  set shellquote= shellxquote=
endif

" = Shortcuts =
let mapleader=","
let maplocalleader=","
" Easy navigation through shortcuts
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" Map <Esc> to exit terminal-mode
tnoremap <Esc> <C-\><C-n>
nnoremap <C-b> <cmd>CHADopen<CR>
nnoremap <leader>l <cmd>call setqflist([])<CR>
" Splits and tabs
nnoremap <leader>s :split<CR>
nnoremap <leader>v :vsplit<CR>
nnoremap <leader>ta :tabnew<CR>
" Create a small terminal below the current window
nnoremap <leader>te :split<CR>:terminal<CR>:resize 10<CR>
" search files with <C-f>
nnoremap <C-f> :Files<CR>

" = Import local vim file =
let localvim=stdpath('config')."/init.local.vim"
if filereadable(localvim)
  exec "source" localvim
endif
