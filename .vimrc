"文字コード設定 
set enc=utf-8
set fencs=utf-8                                                                                                                                                       
"行番号を表示する
set number
"編集中のファイル名を表示
set title
"括弧入力時の対応する括弧を表示
set showmatch
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
set smartindent "現在の行を強調表示
set cursorline
"検索語をハイライト表示
set hlsearch
"バックスペース
set backspace=indent,eol,start
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"vim
call plug#begin('~/.vim/plugged')
  Plug 'fatih/molokai'
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'cohama/lexima.vim'
  Plug 'preservim/nerdtree'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/asyncomplete.vim'
  Plug 'prabirshrestha/asyncomplete-lsp.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'mattn/vim-lsp-settings'
  Plug 'mattn/vim-goimports'
  "TyepScript
  Plug 'ryanolsonx/vim-lsp-typescript'
call plug#end()

"scheme
let g:rehash256 = 1
colorscheme molokai

nmap <silent> gd <plug>(lsp-definition)
au FileType go nmap <silent> gt <plug>(lsp-type-definition) 
au FileType go nmap <silent> gr <plug>(lsp-rename) 

"NERDTreeToggle
nnoremap <silent><C-e> :NERDTreeToggle<CR>
"vim-line tab
let g:airline#extensions#tabline#enabled = 1
"tabの前後
nmap <C-m> <Plug>AirlineSelectPrevTab
nmap <C-n> <Plug>AirlineSelectNextTab
