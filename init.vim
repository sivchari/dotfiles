"文字コード設定
set enc=utf-8

"行番号を表示する
set number

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

"バックスペース
set backspace=indent,eol,start

set write
set modifiable

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

if dein#check_install()
  call dein#install()
endif

call map(dein#check_clean(), "delete(v:val, 'rf')")

nmap <silent> gd :LspDefinition<CR>
nmap <silent> gr :LspRename<CR>
nmap <silent> fi :LspCodeAction<CR>
nmap <silent> gi :LspImplementation<CR>
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_text_edit_enabled = 0

nmap <C-a> <Plug>AirlineSelectPrevTab
nmap <C-s> <Plug>AirlineSelectNextTab

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
    " wincmd p
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

" vim-goimpl
nmap <silent> gi :GoImpl<CR>

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

" neoterm
tnoremap <silent> <C-w> <C-\><C-n><C-w>
autocmd TermOpen * startinsert
nmap <silent> nt :<C-u>silent call <SID>new_terminal()<CR>
function! s:new_terminal() abort
    let split = s:split_type()
    if split ==# 'split'
        execute('Term')
    elseif split ==# 'vsplit'
        execute('VTerm')
    endif
endfunction


" for acme editor color
hi clear 
let g:colors_name = "acme"
let s:white = "#ffffff"
let s:black = "#000000"
let s:pale_yellow = "#ffffea"
let s:dark_yellow = "#eeee9e"
let s:dark_green = "#99994c"
let s:pale_blue = "#eaffff"
let s:cyan = "#9eeeee"
let s:purple = "#8888cc"
let s:blue = "#000099"
let s:red = "#aa0000"
let s:green = "#006600"
exe 'hi! Normal guibg='.s:pale_yellow.' guifg='.s:black.' ctermbg=230 ctermfg=232 '
exe 'hi! NonText guibg=bg guifg='.s:red.' ctermbg=bg ctermfg=232'
exe 'hi! StatusLine guibg='.s:purple.' guifg='.s:white.' gui=NONE ctermbg=159 ctermfg=232 cterm=NONE'
exe 'hi! StatusLineNC guibg='.s:pale_blue.' guifg='.s:black.' gui=NONE ctermbg=194 ctermfg=232 cterm=NONE'
exe 'hi! WildMenu guibg='.s:black.' guifg='.s:pale_blue.' gui=NONE ctermbg=black ctermfg=159 cterm=NONE'
exe 'hi! VertSplit guibg='.s:pale_yellow.' guifg='.s:dark_green.' gui=NONE ctermbg=bg ctermfg=232 cterm=NONE'
exe 'hi! Folded guibg='.s:dark_green.' guifg=fg gui=italic ctermbg=187 ctermfg=fg cterm=italic'
exe 'hi! FoldColumn guibg='.s:dark_green.' guifg=fg ctermbg=229 ctermfg=fg'
exe 'hi! SignColumn guibg='.s:dark_green.' guifg=fg ctermbg=229 ctermfg=fg'
exe 'hi! Conceal guibg=bg guifg=fg gui=NONE ctermbg=bg ctermfg=fg cterm=NONE'
exe 'hi! LineNr guibg=bg guifg='.s:dark_green.' gui=italic ctermbg=bg ctermfg=239'
exe 'hi! Visual guibg='.s:dark_yellow.' guifg=fg ctermbg=fg ctermfg=bg'
exe 'hi! CursorLine guibg='.s:dark_yellow.' guifg=fg ctermbg=230 ctermfg=fg'
exe 'hi! CursorLineNR guibg=bg guifg='.s:dark_green.' ctermbg=230 ctermfg=fg'
exe 'hi! Cursor guibg='.s:dark_green.' guifg=fg ctermbg=230 ctermfg=fg'
exe 'hi! MatchParen guibg='.s:green.' guifg='.s:white.' ctermbg=230 ctermfg=fg'
exe 'hi! Search guibg='.s:green.' guifg='.s:white.' ctermbg=230 ctermfg=fg'
exe 'hi! ErrorMsg guibg='.s:red.' guifg='.s:white.' ctermbg=230 ctermfg=fg'
exe 'hi! Pmenu guibg='.s:dark_yellow.' guifg='.s:black.' ctermbg=230 ctermfg=fg'
exe 'hi! PmenuSel guibg='.s:green.' guifg='.s:white.' ctermbg=230 ctermfg=fg'
exe 'hi! PmenuSbar guibg='.s:dark_green.' guifg='.s:black.' ctermbg=230 ctermfg=fg'
exe 'hi! PmenuThumb guibg='.s:dark_yellow.' guifg='.s:black.' ctermbg=230 ctermfg=fg'
exe 'hi! TabLineFill guibg='.s:pale_blue.' guifg='.s:pale_blue.' gui=NONE ctermbg=230 ctermfg=fg cterm=NONE'
exe 'hi! TabLine guibg='.s:pale_blue.' guifg='.s:black.' gui=NONE ctermbg=230 ctermfg=fg'
exe 'hi! TabLineSel guibg='.s:purple.' guifg='.s:white.' gui=NONE ctermbg=230 ctermfg=fg cterm=NONE'
" Syntax
exe 'hi! Comment guibg=bg guifg='.s:dark_green.' gui=NONE ctermbg=bg ctermfg=236 cterm=NONE'
exe 'hi! Todo guibg=bg guifg='.s:dark_green.' gui=NONE ctermbg=bg ctermfg=236 cterm=NONE'
exe 'hi! Statement guibg=bg guifg=fg gui=NONE ctermbg=bg ctermfg=fg cterm=NONE'
exe 'hi! Identifier guibg=bg guifg=fg gui=NONE ctermbg=bg ctermfg=fg cterm=NONE'
exe 'hi! Type guibg=bg guifg=fg gui=NONE ctermbg=bg ctermfg=fg cterm=NONE'
exe 'hi! PreProc guibg=bg guifg=fg gui=NONE ctermbg=bg ctermfg=fg cterm=NONE'
exe 'hi! Constant guibg=bg guifg=fg gui=NONE ctermbg=bg ctermfg=fg cterm=NONE'
exe 'hi! Special guibg=bg guifg=fg gui=NONE ctermbg=bg ctermfg=fg cterm=NONE'
exe 'hi! SpecialKey guibg=bg guifg=fg gui=NONE ctermbg=bg ctermfg=fg cterm=NONE'
exe 'hi! Directory guibg=bg guifg=fg gui=NONE ctermbg=bg ctermfg=fg cterm=NONE'
exe 'hi! Error guibg='.s:red.' guifg='.s:white.' gui=NONE ctermbg=230 ctermfg=fg'
exe 'hi! link Title TabLineSel'
exe 'hi! link MoreMsg Comment'
exe 'hi! link Question Comment'
" vim
hi link vimFunction Identifier
