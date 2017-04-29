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

" Tree file browser
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

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

" Latex
Plug 'lervag/vimtex'

" Autocompletion
Plug 'Shougo/deoplete.nvim'
Plug 'zchee/deoplete-jedi'

call plug#end()





" =====> Configuration
"--------------------------------------

" Use ripgrep for grepprg
set grepprg=rg\ --vimgrep


" =====> Tools
"--------------------------------------

" Find command (:Find)
" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search
"   (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call
	\ fzf#vim#grep('rg --column --line-number
	\ --no-heading --fixed-strings --ignore-case
	\ --no-ignore --hidden --follow --glob "!.git/*"
	\ --color "always" '.shellescape(<q-args>), 1, <bang>0)
