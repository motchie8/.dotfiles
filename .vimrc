set nocompatible
filetype off

" directory to install plugins
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
    if !isdirectory(s:dein_repo_dir)
        execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
    endif
    execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    let g:rc_dir    = expand('~/.vim/rc')
    let s:toml      = g:rc_dir . '/dein.toml'
    let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

    call dein#load_toml(s:toml,      {'lazy': 0})
    call dein#load_toml(s:lazy_toml, {'lazy': 1})

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
    call dein#install()
endif

if isdirectory(expand($PYENV_PATH))
    let g:python3_host_prog = $PYENV_PATH . '/versions/neovim3/bin/python'
    let g:python_host_prog = $PYENV_PATH . '/versions/neovim2/bin/python'
endif

" Unite vim settings
"let g:unite_enable_start_insert=1
" buffers
"noremap <C-P> :Unite buffer<CR>
" files
"noremap <C-N> :Unite -buffer-name=file file<CR>
" recent
"noremap <C-Z> :Unite file_mru<CR>
" current dir
"noremap :uff :<C-u>UniteWithBufferDir file -buffer-name=file<CR>
" split window
"au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
"au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" exit with esc double
"au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
"au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

" keymapping
inoremap <C-i> <Esc>
inoremap <C-j>  <down>
inoremap <C-k>  <up>
inoremap <C-h>  <left>
inoremap <C-l>  <right>

noremap <S-h> ^
noremap <S-l> $

nnoremap <silent> <Space>f "zyiw:let @/ = '\<' . @z . '\>'<CR>:set hlsearch<CR>
nmap <Space>r <Space>f:%s/<C-r>///g<Left><Left>
nnoremap <silent> <Esc><Esc> :<C-u>set nohlsearch!<CR>

" tab intent
set expandtab
set tabstop=4

" serach
set ignorecase
set smartcase
set hlsearch
set incsearch

" cursor
set number
set cursorline
set showmatch

" other settings
set noswapfiledjj
set whichwrap=b,s,h,l,<,>,[,]
set backspace=indent,eol,start

" autocomplete
inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap ( ()<ESC>i
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap [ []<ESC>i
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap ' ''<LEFT>
inoremap " ""<LEFT>

" color schema
syntax on
set t_Co=256
colorscheme iceberg
" gosukiwi/vim-atom-dark

" detect filetype
filetype plugin indent on
