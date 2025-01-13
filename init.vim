" Add plugins
call plug#begin()
Plug 'nvim-lua/plenary.nvim'             " Required for telescope.nvim
Plug 'projekt0n/github-nvim-theme'       " Tree-sitter-compatible GitHub theme
Plug 'nvim-treesitter/nvim-treesitter'   " Parsing system and library
Plug 'junegunn/fzf.vim'                  " Alternative to telescope.nvim based on fzf
Plug 'ellisonleao/gruvbox.nvim'          " Tree-sitter-compatible Gruvbox theme
Plug 'L3MON4D3/LuaSnip'                  " Snippet engine for reusable templates
Plug 'neovim/nvim-lspconfig'             " Basic defaults for Neovim's LSP client
Plug 'hrsh7th/cmp-nvim-lsp'              " Completion engine
Plug 'hrsh7th/cmp-buffer'                " Required for nvim-cmp
Plug 'hrsh7th/cmp-path'                  " Required for nvim-cmp
Plug 'hrsh7th/cmp-cmdline'               " Required for nvim-cmp
Plug 'hrsh7th/nvim-cmp'                  " Completion engine
Plug 'saadparwaiz1/cmp_luasnip'          " LuaSnip completion source for nvim-cmp
call plug#end()

" Expand tabs to spaces
set tabstop     =2
set softtabstop =2
set shiftwidth  =2
set expandtab

" Configure colors
let theme = trim(system('theme get'))
if theme == "light"
	colorscheme github_light
else
  colorscheme gruvbox
endif

" Line numbers
set nu cursorline
hi CursorLineNr guifg=15

" Map clipboard to default buffer
set clipboard+=unnamedplus

" Disable swap files
set noswapfile

" Search files with fzf
noremap <C-P> :Files <CR>

" Search for input
noremap <C-g> :Ag<CR>

" Set up rename for refactoring
command! Rename lua vim.lsp.buf.rename()

command! Full lua vim.diagnostic.open_float()

let mapleader = " "
nnoremap <leader>lr :LspRestart<CR>

lua require('colorscheme')
lua require('treesitter')
lua require('lsp')
lua require('go')
lua require('completion')
lua require('snippets')
lua require('diagnostic')
