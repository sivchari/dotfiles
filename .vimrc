colorscheme lucius
set background=dark
let g:ligthline = { 'colorscheme': 'lucius' }

set shell=bash
"文字コード設定
set enc=utf-8
"行番号を表示する
set number

"編集中のファイル名を表示
set title

"括弧入力時の対応する括弧を表示
" set showmatch

"コードの色分け
syntax on

"インデントをスペース4つ分に設定
set tabstop=4

"vimの自動生成するインデントをスペース4つに
set shiftwidth=4

"Tab半角スペース
set expandtab

"改行時に前の行のインデントを継続する
set autoindent

"改行時に前の行の構文をチェックし次の行のインデントを増減する
set smartindent

"現在の行を強調表示
set cursorline

"検索語をハイライト表示
set hlsearch

"バックスペース
set backspace=indent,eol,start

" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"vim
call plug#begin('~/.vim/plugged')
  Plug 'bronson/vim-trailing-whitespace'

  Plug 'ctrlpvim/ctrlp.vim'

  Plug 'cohama/lexima.vim'

  Plug 'preservim/nerdtree'

  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'Shougo/deoplete.nvim'
  Plug 'lighttiger2505/deoplete-vim-lsp'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'mattn/vim-goimports'
call plug#end()

nmap <silent> gd <plug>(lsp-definition)
au FileType go nmap <silent> gt <plug>(lsp-type-definition)
au FileType go nmap <silent> gr <plug>(lsp-rename)
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:asyncomplete_popup_delay = 200
let g:lsp_text_edit_enabled = 0

"NERDTreeToggle
nnoremap <silent><C-e> :NERDTreeToggle<CR>

"tabの前後
nmap <C-m> <Plug>AirlineSelectPrevTab
nmap <C-n> <Plug>AirlineSelectNextTab

"vim-line tab
let g:airline_theme = 'jellybeans'
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_theme = "hybrid"

