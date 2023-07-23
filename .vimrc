call plug#begin('~/.vim/plugged')
Plug 'olimorris/onedarkpro.nvim'
Plug 'antoniofranzese/ctrlsf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/nerdtree'
Plug 'preservim/nerdcommenter'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'williamboman/nvim-lsp-installer'
Plug 'neovim/nvim-lspconfig'
"Plug 'ms-jpq/coq_nvim', {'commit': '5eddd31bf8a98d1b893b0101047d0bb31ed20c49'}
Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'ms-jpq/coq.thirdparty', {'branch': '3p'}
Plug 'WhoIsSethDaniel/toggle-lsp-diagnostics.nvim'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'itchyny/lightline.vim'
Plug 'tanvirtin/monokai.nvim'
call plug#end()

syntax enable
colorscheme monokai_pro

" options
set autoindent smartindent
set clipboard+=unnamedplus "Configure clipboard
set mouse=a "Use mouse on vim

" Tab
set tabstop=4                 "" number of visual spaces per TAB
set softtabstop=4             "" number of spacesin tab when editing
set shiftwidth=4              "" insert 4 spaces on a tab
set expandtab            "" tabs are spaces, mainly because of python

"" UI config
set number               "" show absolute number
set cursorline           "" highlight cursor line underneath the cursor horizontally
set splitbelow           "" open new vertical split bottom
set splitright           "" open new horizontal splits right
"" vim.opt.termguicolors = true     enabl 24-bit RGB color in the TUI
set noshowmode            "" we are experienced, wo don't need the -- INSERT -- mode hint

" Searching
set incsearch            "" search as characters are entered
set hlsearch            "" do not highlight matches
set ignorecase           "" ignore case in searches by default
set smartcase           "" but make it case sensitive if an uppercase is entered

" IDE Config Start
let $JAVA_HOME = '/home/sbyderman/.sdkman/candidates/java/20.0.2-zulu'

lua << EOF

require("nvim-lsp-installer").setup {}
require("toggle_lsp_diagnostics").init {}
-- vim.g.python3_host_prog='/usr/bin/python3.10'
vim.g.coq_settings = {
	auto_start = 'shut-up',
	display = {
		icons = {
			mode = 'none'
		}
	},
	keymap = {
		pre_select = false
	}
}

local coq = require( 'coq' )
local lsp = require( 'lspconfig' )

lsp.jdtls.setup { coq.lsp_ensure_capabilities {} }
lsp.jdtls.setup {
	use_lombok_agent = true 
}

EOF

set ts=4 
set sw=4 
set autoindent 
set nocompatible 
set hidden 
syntax on
nnoremap - @@
let mapleader = ","
let maplocalleader = " "

" RainbowParentheses
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{','}']]
autocmd VimEnter * RainbowParentheses

" Diff
if &diff
	nmap dn ]c
	nmap db [c
	nmap +d ]c
	nmap -d [c
	nmap <leader>p dp]c
	nmap <localleader>P :%diffput<CR>:xa<CR>
	nmap <localleader>q :qa!<CR>
	autocmd VimEnter * norm ]c
endif

" Format
nnoremap <silent> <leader>fx :%!xmllint --format -<CR>:set filetype=xml<CR>
vnoremap <silent> <leader>fx :'<,'>!xmllint --format -<CR>
"nnoremap <silent> <leader>fJ :%!python -m json.tool<CR>:set filetype=json<CR>
"vnoremap <silent> <leader>fJ :'<,'>!python -m json.tool<CR>
nnoremap <silent> <leader>fj :%!jq .<CR>:set filetype=json<CR>
vnoremap <silent> <leader>fj :'<,'>!jq .<CR>
nnoremap <silent> <leader>fJ :%!jq -c .<CR>:set filetype=json<CR>
vnoremap <silent> <leader>fJ :'<,'>!jq -c .<CR>

" CtrlSF
let g:ctrlsf_backend = 'rg'
let g:ctrlsf_position = 'bottom'
let g:ctrlsf_search_mode = 'async'
let g:ctrlsf_regex_pattern = 1
let g:ctrlsf_case_sensitive = 'no'
let g:ctrlsf_auto_focus = { "at": "start" }
let g:ctrlsf_extra_backend_args = {
	\ 'rg': '--iglob !target --block-buffered --crlf'
	\ }
let g:search_escape = '\\/.*$^~[]'

" CtrlSF visual selection
" nnoremap /s yiw:CtrlSF <C-R>=escape(@",g:search_escape)<CR>
vnoremap /s y:CtrlSF '<C-R>=escape(@",g:search_escape)<CR>'
nnoremap <localleader>s yiw:wa<CR>:CtrlSF '<C-R>=escape(@",g:search_escape)<CR>'<CR>
vnoremap <localleader>s y:wa<CR>:CtrlSF '<C-R>=escape(@",g:search_escape)<CR>'<CR>

" NERDTree 
nmap <silent> <localleader>n :NERDTreeToggle<CR>
nmap <silent> <localleader>nr :NERDTreeRefreshRoot<CR>
" nmap <leader>nf :NERDTreeFind<CR> 
nmap <leader>nr :NERDTree %<CR>
nmap <silent> <localleader>b :Buffers<CR>
let NERDTreeMinimalUI=1
let NERDTreeChDirMode=3
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif

" FZF/ripgrep visual selection
"nnoremap /g yiw:Rg <C-R>=escape(@",g:search_escape)<CR>
vnoremap /g y:Rg <C-R>=escape(@",g:search_escape)<CR>
nnoremap <localleader>g yiw:Rg <C-R>=escape(@",g:search_escape)<CR><CR>
vnoremap <localleader>g y:Rg <C-R>=escape(@",g:search_escape)<CR><CR>

" FZF
nmap <silent> <localleader>f :Files<CR>
let g:fzf_preview_window = ['up:60%', 'ctrl-/']
let g:fzf_height = 30

command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, {'source': 'fd --type f --exclude target', 'options': ['-i']}, <bang>0)
