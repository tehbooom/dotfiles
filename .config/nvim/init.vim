set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set relativenumber
set wildmode=longest,list   " get bash-like tab completions
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
set noswapfile            " disable creating swap file

" BUTT PLUGS
call plug#begin()
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'neovim/nvim-lspconfig'
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-sandwich'
Plug 'morhetz/gruvbox'
Plug 'ryanoasis/vim-devicons'
call plug#end()

autocmd VimEnter * CHADopen --nofocus
autocmd VimEnter * COQnow -s
autocmd vimenter * ++nested colorscheme gruvbox
autocmd BufEnter * if (winnr("$") == 1 && &filetype == "CHADTree") | q | endif

" IM THE MAP

nnoremap <C-o> :CHADopen --nofocus<CR>



" Snippets
lua require'lspconfig'.gopls.setup{}
lua require'lspconfig'.bashls.setup{}
lua require'lspconfig'.dockerls.setup{}
lua require'lspconfig'.jsonls.setup{}
lua require'lspconfig'.pyright.setup{}
lua require'lspconfig'.terraform_lsp.setup{}
lua require'lspconfig'.vimls.setup{}
lua require'lspconfig'.yamlls.setup{}
lua require'lspconfig'.ansiblels.setup{}
