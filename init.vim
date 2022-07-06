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

nmap <C-a> <Plug>AirlineSelectPrevTab
nmap <C-s> <Plug>AirlineSelectNextTab

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

" k9s
nmap <silent> k9 :<C-u>silent call <SID>k9s()<CR>
function! s:k9s() abort
    let split = s:split_type()
    execut printf('%s k9s', split)

    if split ==# 'split'
        execute(printf('resize %s', floor(&lines * 0.3)))
    endif
    call termopen('k9s')
endfunction


" gobang
nmap <silent> gb :<C-u>silent call <SID>gobang()<CR>
function! s:gobang() abort
    let split = s:split_type()
    execut printf('%s gobang', split)

    if split ==# 'split'
        execute(printf('resize %s', floor(&lines * 0.3)))
    endif
    call termopen('gobang')
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

" cargo test
nmap <silent> cr :<C-u>silent call <SID>rust_execute_test()<CR>
function! s:rust_execute_test()
	const FUNCTION_SEARCH_STATE = "function-search"
	const MOD_SEARCH_STATE = "mod-search"
	const FILE_SEARCH_STATE = "file-search"
	let test_path = []
	let state = FUNCTION_SEARCH_STATE
	let function_found = v:false
	let view = winsaveview()
	let lnum = view['lnum']
	let col = view['col']
	normal! [{
	while lnum != line(".") || col != col(".")
		if state == FUNCTION_SEARCH_STATE
			let function_name = s:is_test_function_block()
			if function_name != -1
				let test_path += [function_name]
				let function_found = v:true
				let state = MOD_SEARCH_STATE
			else
				let mod_name = s:is_mod_block()
				if mod_name != -1
					let test_path += [mod_name]
					let state = MOD_SEARCH_STATE
				endif
			endif
		elseif state == MOD_SEARCH_STATE
			let mod_name = s:is_mod_block()
			if mod_name != -1
				let test_path += [mod_name]
			endif
		endif
		let lnum = line(".")
		let col = col(".")
		normal! [{
	endwhile
	let cargo_arguments = "test --all-features"
	let file_path = []
	for segment in split(expand("%:p:r"), '/')
		" Before 'src', discard every segment of the path
		if segment == "src"
			let cargo_arguments .= " --lib"
			let state = FILE_SEARCH_STATE
		elseif segment == "tests"
			let cargo_arguments .= " --test " . expand("%:t:r")
			break
		elseif state == FILE_SEARCH_STATE
			" Every segment of the path is now a module (folder or files) at the 
			" exception of `lib.rs` and `main.rs`
			if segment != "lib" && segment != "main"
				let file_path += [segment]
			endif
		endif
	endfor
	let test_path = file_path + reverse(test_path)
	if function_found
		let cargo_arguments .= " -- --exact "
	else
		let cargo_arguments .= " -- "
	endif
	let cargo_arguments .= join(test_path, "::")
    let split = s:split_type()
    execut printf('%s cargo', split)

    if split ==# 'split'
        execute(printf('resize %s', floor(&lines * 0.3)))
    endif

	" Run cargo command
    call termopen(printf("cargo %s", cargo_arguments))
endfunction

function! s:extract_name(pattern)
	let view = winsaveview()
	let lnum = search(a:pattern, "b")
	call winrestview(view)
	let line = getline(lnum)
	let name = matchstr(line, a:pattern)
	return name
endfunction

function! s:is_test_function_block()
	const test_prefix_pattern = '#\[test\]\_.\{-}'
	const prefix_pattern = '\<fn\>\s\+'
	const function_name_pattern = '\<\h\w*\>'
	const suffix_pattern = '[<(\s][^{]\+'
	let is_test_function_block = s:is_opening_block(test_prefix_pattern . prefix_pattern . function_name_pattern . suffix_pattern)
	if is_test_function_block
		let function_name = s:extract_name(prefix_pattern . '\zs\(' . function_name_pattern . '\)')
		return function_name
	endif
	return -1
endfunction

function! s:is_mod_block()
	const prefix_pattern = '\<mod\>\s\+'
	const mod_name_pattern = '\<\h\w*\>'
	const suffix_pattern = '\s\+'
	let is_test_mod_block = s:is_opening_block(prefix_pattern . mod_name_pattern . suffix_pattern)
	if is_test_mod_block
		let mod_name = s:extract_name(prefix_pattern . '\zs\(' . mod_name_pattern . '\)')
		return mod_name
	endif
	return -1
endfunction

function! s:is_opening_block(preblock_pattern)
	let view = winsaveview()
	" If we search for the pattern but we are already on it, we're gonna find 
	" the next one (search forward) or the previous one (search backward) but 
	" not the current one.
	" To avoid this, we move one character forward and we're gonna search 
	" backward.
	execute "normal! l"
	" if we're at the end of the line
	if col(".") == view["col"] + 1
		" move to the beginning of next line
		execute "normal! j0"
	endif
	let [lnum, col] = searchpos(a:preblock_pattern . '\zs{\ze', "b")
	call winrestview(view)
	if lnum == line(".") && col == col(".")
		let result = v:true
	else
		let result = v:false
	endif
	return result
endfunction
