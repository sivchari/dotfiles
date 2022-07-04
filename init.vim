"文字コード設定
set enc=utf-8

"行番号を表示する
set number

"編集中のファイル名を表示
set title

"括弧入力時の対応する括弧を表示
"set showmatch

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

set write
set modifiable

" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>

if &compatible
  set nocompatible
endif

" Add the dein installation directory into runtimepath
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')
  let s:toml_dir = $HOME . '/.vim/dein'
  let s:toml = s:toml_dir . '/dein.toml'

  call dein#load_toml(s:toml, {})
  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

call map(dein#check_clean(), "delete(v:val, 'rf')")
" :call dein#recache_runtimepath()

nmap <silent> gd :LspDefinition<CR>
nmap <silent> gr :LspRename<CR>
nmap <silent> fi :LspCodeAction<CR>
nmap <silent> gi :LspImplementation<CR>
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:asyncomplete_popup_delay = 200
let g:lsp_text_edit_enabled = 0

nmap <C-q> <Plug>AirlineSelectPrevTab

inoremap <silent> jj <ESC>

let g:quickrun_config = {}
autocmd BufNewFile,BufRead *.crs setf rust
autocmd BufNewFile,BufRead *.rs  let g:quickrun_config.rust = {'exec' : 'cargo run'}
autocmd BufNewFile,BufRead *.crs let g:quickrun_config.rust = {'exec' : 'cargo script %s -- %a'}
autocmd BufNewFile,BufRead *.go let g:quickrun_config.go = {'exec' : 'go run main.go'}

"fern.vim
nnoremap <C-q> :Fern . -reveal=% -drawer -toggle -width=40<CR>
let g:fern#default_hidden=1

"fzf+rg
"gu
nmap <silent> gf :Files<CR>
nmap <silent> gu :<C-u>silent call <SID>find_rip_grep()<CR>
function! s:find_rip_grep() abort
    call fzf#vim#grep(
                \   'rg --ignore-file ~/.ignore --column --line-number --no-heading --hidden --smart-case .+',
                \   1,
                \   fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%', '?'),
                \   0,
                \ )
endfunction

"go-test-name
nmap <silent> gt :<C-u>silent call <SID>go_test_function()<CR>
function! s:go_test_function() abort
    let test_info = json_decode(system(printf('go-test-name -pos %s -file %s', s:cursor_byte_offset(), @%)))

    for b in nvim_list_bufs()
        if bufname(b) ==# 'vim-go-test-func'
            execute printf('bwipe! %s', b)
        endif
    endfor

    let dir = expand('%:p:h')

    if len(test_info.sub_test_names) > 0
        "bash
        "let cmd = printf("go test -coverprofile='/tmp/go-coverage.out' -count=1 -v -race -run='^%s$'/'^%s$' $(go list %s)", test_info.test_func_name, test_info.sub_test_names[0], dir)
        let cmd = printf("go test -coverprofile='/tmp/go-coverage.out' -count=1 -v -race -run='^%s$'/'^%s$' (go list %s)", test_info.test_func_name, test_info.sub_test_names[0], dir)
    else
        "bash
        "let cmd = printf("go test -coverprofile='/tmp/go-coverage.out' -count=1 -v -race -run='^%s$' $(go list %s)", test_info.test_func_name, dir)
        let cmd = printf("go test -coverprofile='/tmp/go-coverage.out' -count=1 -v -race -run='^%s$' (go list %s)", test_info.test_func_name, dir)
    endif

    let split = s:split_type()
    execut printf('%s gotest', split)

    if split ==# 'split'
        execute(printf('resize %s', floor(&lines * 0.3)))
    endif

    call termopen(cmd)
    setlocal bufhidden=delete
    setlocal noswapfile
    setlocal nobuflisted
    file vim-go-test-func
    wincmd p
endfunction

function! s:cursor_byte_offset() abort
    return line2byte(line('.')) + (col('.') - 2)
endfunction

function! s:split_type() abort
    " NOTE: my cell ratio: width:height == 1:2.1
    let width = winwidth(win_getid())
    let height = winheight(win_getid()) * 2.1

    if height > width
        return 'split'
    else
        return 'vsplit'
    endif
endfunction

"dlv
nmap <silent> db  :DlvDebug<CR>
nmap <silent> bp  :DlvAddBreakpoint<CR>
nmap <silent> bpc :DlvClearAll<CR>

" vim-go-expr
nmap <silent> ge :<C-u>silent call go#expr#complete()<CR>

" preview-markdown
let g:previm_open_cmd = 'open -a Google\ Chrome'

" rainbow
let g:rainbow_active = 1

" win_resizer
let g:winresizer_gui_enable = 1

" delta
nmap <silent> dl :<C-u>silent call <SID>delta()<CR>
function! s:delta() abort
    let split = s:split_type()
    execut printf('%s delta', split)

    if split ==# 'split'
        execute(printf('resize %s', floor(&lines * 0.3)))
    endif
    call termopen('git diff')
endfunction


" golangci-lint
nmap <silent> gl :<C-u>silent call <SID>golangci()<CR>
function! s:golangci() abort
    let split = s:split_type()
    execut printf('%s gl', split)

    if split ==# 'split'
        execute(printf('resize %s', floor(&lines * 0.3)))
    endif
    call termopen('golangci-lint run ./... -v')
endfunction

let mapleader = ","

" lazygit
nnoremap <silent> <Leader>g :<C-u>silent call <SID>lazygit()<CR>
function! s:lazygit() abort
    let split = s:split_type()
    execut printf('%s lazygit', split)

    if split ==# 'split'
        execute(printf('resize %s', floor(&lines * 0.3)))
    endif
    call termopen('lazygit')
endfunction

" easymotion
map <Leader> <Plug>(easymotion-prefix)
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" s{char}{char} to move to {char}{char}
nmap <Leader>s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

