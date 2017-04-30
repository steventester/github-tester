"-------------------------------------"
"yiqiaoaowang's neovim configuration  "
"-------------------------------------"
"   incompatible with vim (probably)  "

 
" =====> Plugins
"--------------------------------------
" Setup vim.plug as needed
call plug#begin('~/.local/share/nvim/plugged')

" Git wrapper
Plug 'tpope/vim-fugitive'

" Snippets
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" Undo-tree visualizer
Plug 'simnalamburt/vim-mundo'

" Deal with parens and quotes etc.
Plug 'tpope/vim-surround'

" Fix netrw
Plug 'tpope/vim-vinegar'

" Tags by scope
Plug 'majutsushi/tagbar'

" Make commenting easier
Plug 'scrooloose/nerdcommenter'

" Show diffs in the gutter
Plug 'airblade/vim-gitgutter'

" Jump around easier
Plug 'easymotion/vim-easymotion'

" Async linting
Plug 'w0rp/ale'

" Status line
Plug 'vim-airline/vim-airline'

" Align text
Plug 'godlygeek/tabular'

" Multiple cursors
Plug 'terryma/vim-multiple-cursors'

" Auto pairs
Plug 'jiangmiao/auto-pairs'

" Autocompletion - YouCompleteMe
" see https://valloric.github.io/YouCompleteMe/ 
"
" Options for youcompleteme
" C-family languages: --clang-completer
" C# support: install Mono and add --omnisharp-completer when calling ./install.py.
" Go support: install Go and add --gocode-completer when calling ./install.py.
" TypeScript support: install Node.js and npm then install the TypeScript SDK with npm install -g typescript.
" JavaScript support: install Node.js and npm and add --tern-completer when calling ./install.py.
" Rust support: install Rust and add --racer-completer when calling ./install.py.
"
" --all: depends on go, tsserver, node, npm, rustc, and cargo
"
" It is advised to not use system libclang. 
" Python is builtin.


Plug 'valloric/youcompleteme', { 'do' : '~/.local/share/nvim/plugged/
	\ youcompleteme/install.py
	\ --clang-completer
	\ --racer-completer' }

call plug#end()


" =====> Configuration
"--------------------------------------

let g:mapleader = ","  " Set leader as comma
set hidden  " Allow me to open another buffer without saving
set splitbelow  " New splits below
set splitright  " New splits right

set grepprg=rg\ --vimgrep " Use ripgrep for grepprg


" Highlight 81st column
set colorcolumn=81
" Always show status bar
set laststatus=2
" Disable mouse click to go to position
set mouse-=a


" =====> Other fun stuff
"--------------------------------------
