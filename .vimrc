
" ---------------------------------------
""" Basic Setup
"---------------------------------------

" Encoding dectection without BOM
set encoding=utf-8 nobomb
"set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
"set fileencoding=utf-8
" Optimize for fast terminal connections
set ttyfast

" Enable filetype dectection and ft specific plugin/indent
"filetype plugin indent on

" enable syntax hightlight and completion
syntax on

" Enhancee command-line completion
set wildmenu

"--------
" Vim UI
"--------
" Color scheme
set background=dark
"color pablo

" Highlight current line
"au WinLeave * set nocursorline nocursorcolumn
"au WinEnter * set cursorline cursorcolumn
"set cursorline cursorcolumn

" Search
set incsearch
" Highlight searches
set hlsearch

" Conflict with highlight current line
"set highlight 	
set ignorecase
set smartcase

"set fileformats=unix,dos,mac

" Respect modeline in files
set modeline
set modelines=4

" Show the current mode
set showmode

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif


" editor settings
set history=1000
set nocompatible                                                  " be iMproved
set nofoldenable                                                  " disable folding"
set confirm                                                       " prompt when existing from an unsaved file
set backspace=indent,eol,start                                    " More powerful backspacing
set t_Co=256                                                      " Explicitly tell vim that the terminal has 256 colors 
set mouse=a                                                       " use mouse in all modes
set ruler                                                         " show the cursor position
set nostartofline                                                 " don't reset cursor to start of line when moving around 
set report=0                                                      " always report number of lines changed                
set nowrap                                                        " dont wrap lines
set scrolloff=5                                                   " 5 lines above/below cursor when scrolling
"set number                                                        " show line numbers
set showmatch                                                     " show matching bracket (briefly jump)
set showcmd                                                       " show typed command in status bar
set showmode                                                      "show the current mode
set title                                                         " show file in titlebar
"set laststatus=2                                                  " use 2 lines for the status bar
set matchtime=2                                                   " show matching bracket for 0.2 seconds
set matchpairs+=<:>                                               " specially for html
if exists("&relativenumber")                                      
    set relativenumber
    au BufReadPost * set relativenumber
endif                                                             "show relative line number

" Don't add empty newlines at the end of files
set binary
set noeol

" Dont't create backups when editing files in certain directories
set backupskip=/tmp/*,/private/tmp/*

filetype off

" Default Indentation
set autoindent
set smartindent     " indent when
set tabstop=4       " tab width
set softtabstop=4   " backspace
set shiftwidth=4    " indent width
" set textwidth=79
" set smarttab
set expandtab       " expand tab to space

autocmd FileType c setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType cpp setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType php setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType ruby setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType coffee,javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
autocmd FileType html,htmldjango,xhtml,haml,javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=0
autocmd FileType sass,scss,css setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120

" syntax support
autocmd Syntax javascript set syntax=jquery   " JQuery syntax support
" js
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"


"-----------------------------
" GUI Setting
"----------------------------
" for macvim
if has("gui_running")
    if has("gui_mac") || has("gui_macvim")
        set go=aAce  " remove toolbar
        "set transparency=5
        "set guifont=Monaco:h13
        set guifont=Source_Code_Pro:h14
        "colorscheme macvim
        "set showtabline=2
        "set columns=140
        "set lines=40
        "noremap <D-M-Left> :tabprevious<cr>
        "noremap <D-M-Right> :tabnext<cr>
        "map <D-1> 1gt
        "map <D-2> 2gt
        "map <D-3> 3gt
        "map <D-4> 4gt
        "map <D-5> 5gt
        "map <D-6> 6gt
        "map <D-7> 7gt
        "map <D-8> 8gt
        "map <D-9> 9gt
        "map <D-0> :tablast<CR>
    endif
else
    let g:CSApprox_loaded = 1

    " Indentline
    let g:indentLine_enabled = 1
    let g:indentLine_concealcursor = 0
    let g:indentLine_char = '┆'
    let g:indentLine_faster = 1

  
    if $COLORTERM == 'gnome-terminal'
        set term=gnome-256color
    else
        if $TERM == 'xterm'
            set term=xterm-256color
        endif
    endif
  
endif

if &term =~ '256color'
    set t_ut=
endif


"------------------
" Useful Functions
"------------------
" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
      \ if ! exists("g:leave_my_cursor_position_alone") |
      \     if line("'\"") > 0 && line ("'\"") <= line("$") |
      \         exe "normal g'\"" |
      \     endif |
      \ endif

" Strip trailing whitespace (,ss)
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" w!! to sudo & write a file
cmap w!! %!sudo tee >/dev/null %

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" sublime key bindings
nmap <D-]> >>
nmap <D-[> <<
vmap <D-[> <gv
vmap <D-]> >gv

" eggcache vim
nnoremap ; :
:command W w
:command WQ wq
:command Wq wq
:command Q q
:command Qa qa
:command QA qa
    
"---------------------
" VundleVim Settings
" --------------------
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

"set rtp+=/usr/local/opt/fzf 

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
"

Plugin 'Valloric/YoucompleteMe'
"Plugin 'SirVer/ultisnips'
Plugin 'rizzatti/dash.vim'

Plugin 'luochen1990/rainbow'
"Plugin 'drmingdrmer/vim-tabbar'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
"Plugin 'vim-airline/vim-airline'
"Plugin 'vim-airline/vim-airline-themes'
Plugin 'w0rp/ale'
Plugin 'justinmk/vim-sneak'
Plugin 'haya14busa/incsearch.vim'
Plugin 'jiangmiao/auto-pairs' 
Plugin 'l04m33/vlime'
Plugin 'godlygeek/csapprox'


let g:make = 'gmake'
if exists('make')
    let g:make='make'
endif
Plugin 'Shougo/vimproc'

"vim tex
Plugin 'lervag/vimtex'

"markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

"c
Plugin 'vim-scripts/c.vim'

"html
"" HTML Bundle
Plugin 'hail2u/vim-css3-syntax'
Plugin 'gorodinskiy/vim-coloresque'
Plugin 'tpope/vim-haml'
Plugin 'mattn/emmet-vim'


" javascript
"" Javascript Bundle
Plugin 'jelera/vim-javascript-syntax'

" All of your Plugins must be added before the following line
call vundle#end() " required
filetype plugin indent on " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList - lists configured plugins
" :PluginInstall - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


"-----------------
" Plugin settings
"---------------
"for rainbow parentheses improved
let g:rainbow_active = 1 " 0 if you want to enable it later via :RainbowToggle

" Rainbow parentheses for Lisp and variants
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
"autocmd Syntax lisp,scheme,clojure,racket,python,RainbowParenthesesTogglei

"YoucompleteMe
let g:ycm_python_interpreter_path='/usr/local/bin/python3'
let g:ycm_python_sys_path = []
let g:ycm_extra_conf_vim_data = [
  \  'g:ycm_python_interpreter_path',
  \  'g:ycm_python_sys_path'
  \]
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_enable_diagnostic_highlighting = 1
let g:ycm_filetype_blacklist = {
      \ 'tagbar': 1,
      \ 'notes': 1,
      \ 'markdown': 1,
      \ 'netrw': 1,
      \ 'unite': 1,
      \ 'text': 1,
      \ 'vimwiki': 1,
      \ 'pandoc': 1,
      \ 'infolog': 1,
      \ 'mail': 1
      \}
"let g:ycm_use_clangd = 1
"let g:ycm_clangd_binary_path = '/usr/local/cellar/llvm/8.0.0_1/bin/clangd'
"let g:ycm_clangd_args = []
"let g:ycm_clangd_uses_ycmd_caching = 1

let g:ycm_semantic_triggers =  {
  \   'c': ['->', '.'],
  \   'objc': ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \            're!\[.*\]\s'],
  \   'ocaml': ['.', '#'],
  \   'cpp,cuda,objcpp': ['->', '.', '::'],
  \   'perl': ['->'],
  \   'php': ['->', '::'],
  \   'cs,d,elixir,go,groovy,java,javascript,julia,perl6,python,scala,typescript,vb': ['.'],
  \   'ruby,rust': ['.', '::'],
  \   'lua': ['.', ':'],
  \   'erlang': [':'],
  \ }



" tabbar
"let g:Tb_MaxSize = 2
"let g:Tb_TabWrap = 1

"hi Tb_Normal guifg=white ctermfg=white
"hi Tb_Changed guifg=green ctermfg=green
"hi Tb_VisibleNormal ctermbg=252 ctermfg=235
"hi Tb_VisibleChanged guifg=green ctermbg=252 ctermfg=white


" Tagbar
let g:tagbar_left=1
let g:tagbar_width=30
let g:tagbar_autofocus = 1
let g:tagbar_sort = 0
let g:tagbar_compact = 1
" tag for coffee
if executable('coffeetags')
  let g:tagbar_type_coffee = {
        \ 'ctagsbin' : 'coffeetags',
        \ 'ctagsargs' : '',
        \ 'kinds' : [
        \ 'f:functions',
        \ 'o:object',
        \ ],
        \ 'sro' : ".",
        \ 'kind2scope' : {
        \ 'f' : 'object',
        \ 'o' : 'object',
        \ }
        \ }

  let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'sort' : 0,
    \ 'kinds' : [
        \ 'h:sections'
    \ ]
    \ }
endif

" Nerd Tree
let NERDChristmasTree=0
let NERDTreeWinSize=30
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$',  '\~$']
let NERDTreeShowBookmarks=1
let NERDTreeWinPos = "right"

" nerdcommenter
let NERDSpaceDelims=1
" nmap <D-/> :NERDComToggleComment<cr>
let NERDCompactSexyComs=1

" powerline  --not used since 2018
"let g:Powerline_symbols = 'fancy'

"airline
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#left_sep = ' '
"let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline#extensions#tabline#formatter = 'default'
"let g:airline_theme="solarized"
"let g:airline_solarized_bg='dark'
"let g:airline_theme="minimalist"

"ale
"let g:ale_sign_column_always = 1 " keep the sign gutter open at all times
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

set statusline=%{LinterStatus()}


"sneak
"let g:sneak#label = 1    "label-mode for a minimalist alternative EasyMotion
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T

" easy-motion
"let g:EasyMotion_leader_key = '<Leader>'

" ctrlp
"set wildignore+=*/tmp/*,*.so,*.o,*.a,*.obj,*.swp,*.zip,*.pyc,*.pyo,*.class,.DS_Store  " MacOSX/Linux
"let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'

"fzf
""nmap <c-p> :Files<CR>
""nmap <c-e> :Buffers<CR>
"let g:fzf_action = { 'crtl-e': 'edit'}

"incsearch
map / <plug>(incsearch-forward)
map ? <plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

"auto-pairs  --fly mode 1 is turn on 0 is not
let g:AutoPairsFlyMode = 0
"let g:AutoPairsShortcutBackInsert = '<M-b'

" Keybindings for plugin toggle
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
nmap <F5> :TagbarToggle<cr>
nmap <F6> :NERDTreeToggle<cr>
nmap  <D-/> :
nnoremap <leader>a :Ack
nnoremap <leader>v V`]


