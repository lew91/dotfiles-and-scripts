
" ---------------------------------------
""" Basic Setup
"---------------------------------------
" Make Vim more useful.
set nocompatible

" Set the default shell.
if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

" When the type of shell script is /bin/sh, assume a POSIX-compatible
" shell for syntax highlighting purposes.
let g:is_posix = 1

" Tell vim to use the .vim path first.
set runtimepath=~/.vim,$VIMRUNTIME

" Optimize for fast terminal connections
set ttyfast

" Enable filetype dectection and ft specific plugin/indent
"filetype plugin indent on

" enable syntax hightlight and completion
syntax on

" Search
set incsearch
" Highlight searches
set hlsearch
" Add the g flag to search/replace by default.
set gdefault

" Conflict with highlight current line
"set highlight 	
set ignorecase
set smartcase

" Set encoding.
if has('multi_byte')
  scriptencoding utf-8
  set encoding=utf-8
  set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,lattin1,cp932,sjis,utf-16le,euc-jp

  if has("win32") || has("win64")
    set termencoding=gbk
  endif
  if has("linux") || has("unix")
    set termencoding=utf-8
  endif
endif

" None word dividers.
set isk+=_,$,@,%,#,-

" Try to detect file formats.
" Unix for new files and autodetect for the rest.
set fileformats=unix,dos,mac

"------------------------------------------------------
""" Vim UI
"----------------------------------------------------
" Enhance command-line completion.
if exists("+wildmenu")
  set wildmenu
  " type of wildmenu
  set wildmode=longest:full,list:full
endif


" Respect modeline in files
set modeline
set modelines=4


" Enable per-directory .vimrc files.
set exrc

" Disable unsafe commands.
set secure


" editor settings
set history=100
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


filetype on

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

"------------------------------------------------------------
""" Colors and Fonts
"------------------------------------------------------------
" Highlight current line
"au WinLeave * set nocursorline nocursorcolumn
"au WinEnter * set cursorline cursorcolumn
"set cursorline cursorcolumn

" Highlight trailing spaces in annoying red.
if has('autocmd')
    highlight ExtraWhitespace ctermbg=1 guibg=red
    match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    if exists('*clearmatches')
      autocmd BufWinLeave * call clearmatches()
    endif
endif

" Reload .vimrc when saving it.
if has("autocmd")
    autocmd BufWritePost .vimrc nested source %
endif

" Highlight conflict markers.
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

if &t_Co > 2 || has("gui_running")
    set background=dark

    " for macvim
    if has("gui_mac") || has("gui_macvim")
        set go=aAce  " remove toolbar
        "set transparency=5
        "set guifont=Monaco:h13
        set guifont=Source_Code_Pro:h14
        "colorscheme macvim
        "set showtabline=2
        "set columns=140
        "set lines=40
        noremap <D-M-Left> :tabprevious<cr>
        noremap <D-M-Right> :tabnext<cr>
        map <D-1> 1gt
        map <D-2> 2gt
        map <D-3> 3gt
        map <D-4> 4gt
        map <D-5> 5gt
        map <D-6> 6gt
        map <D-7> 7gt
        map <D-8> 8gt
        map <D-9> 9gt
        map <D-0> :tablast<CR>
    else
        colorscheme pablo
    endif
else
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

"---------------------------------------------------------
""" Files Editing
"---------------------------------------------------------
" Ignore whitespace in vimdiff.
if &diff
  set diffopt+=iwhite
endif

" Strip trailing whitespaces automatically when saving files of certain type.
if has("autocmd")
  autocmd BufWritePre *.py,*.js,*.php,*.gpx,*.rb,*.tpl :call StripTrailingWhitespaces()
endif


" Dont't create backups when editing files in certain directories
if exists('&backupskip')
  set backupskip+=/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*
endif

" Return to last edit position when opening files. (You want this!)
if has('viminfo')
  if has('autocmd')
     autocmd BufReadPost *\(.git/COMMIT_EDITMSG\)\@<!
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif
  endif
  " Remember info about open buffers on close.
  set viminfo^=%
endif

" Ignore compiled files.
set wildignore=*.o,*~,*.pyc
if has("win32") || has("win64")
  set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
  set wildignore+=.git\*,.hg\*,.svn\*
endif




" When editing a file, always jump to the last cursor position
autocmd BufReadPost *
      \ if ! exists("g:leave_my_cursor_position_alone") |
      \     if line("'\"") > 0 && line ("'\"") <= line("$") |
      \         exe "normal g'\"" |
      \     endif |
      \ endif

" w!! to sudo & write a file
cmap w!! %!sudo tee >/dev/null %

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

"-------------------------------------------
""" Moving and Editing mappings
"------------------------------------------
" gi moves to last insert mode (default)
" gI moves to last modification
nnoremap gI `.

" Movement & wrapped long lines.
nnoremap j gj
nnoremap k gk

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Close the current buffer.
map <leader>bd :Bclose<cr>

" Close all the buffers.
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs.
nnoremap <C-S-Left> :tabprevious<cr>
nnoremap <C-S-Right> :tabnext<cr>
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove<cr>

" Opens a new tab with the current buffer's path.
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer.
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Fast saving, via shortcuts.
nmap <leader>w :w<cr>
nmap <leader>q :q<cr>

" Visual mode pressing * or # searches for the current selection.
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>

" Remap VIM 0 to first non-blank character.
map 0 ^

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Show current file as HTML. (to paste into Keynote)
nmap <Leader>h :TOhtml<CR>:w<cr>:!open %<CR>:q<CR>

" Select all.
map <Leader>a ggVG

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac.
nmap <c-s-Down> mz:m+<cr>`z
nmap <c-s-Up>   mz:m-2<cr>`z
vmap <c-s-Down> :m'>+<cr>`<my`>mzgv`yo`z
vmap <c-s-Up>   :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <c-s-Down>
  nmap <D-k> <c-s-Up>
  vmap <D-j> <c-s-Down>
  vmap <D-k> <c-s-Up>
endif

" map F7 to syntax-check
map <F7> :make <CR>

" Stop opening man pages.
nmap K <nop>

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" strip whitespace (,sw)
noremap <leader>sw :call StripWhitespace()<CR>
" save a file as root (,W)
noremap <leader>W :w !sudo tee % > /dev/null<CR>

inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <s-tab> <C-n>
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' : '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

" Use 'ack' instead of Grep when available.
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor\ --ignore-dir=tmp\ --ignore-dir=coverage
endif

" When you press gv you Ack after the selected text.
vnoremap <silent> gv :call VisualSelection('gv', '')<CR>

" Open Ack and put the cursor in the right position.
map <leader>g :Ack

" When you press <leader>r you can search and replace the selected text.
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>n :cn<cr>
map <leader>p :cp<cr>

" sublime key bindings
nmap <D-]> >>
nmap <D-[> <<
vmap <D-[> <gv
vmap <D-]> >gv


"--------------------------------------------------------
""" Spell checking
"------------------------------------------------------
" Pressing ,ss will toggle and untoggle spell checking.
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>.
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"------------------------------------------------------------
""" File Types
"----------------------------------------------------------
" automatic commands
if has("autocmd")
  " file type detection

  " Ruby
  au BufRead,BufNewFile *.rb,*.rbw,*.gem,*.gemspec set filetype=ruby

  " Ruby on Rails
  au BufRead,BufNewFile *.builder,*.rxml,*.rjs     set filetype=ruby

  " Rakefile
  au BufRead,BufNewFile [rR]akefile,*.rake         set filetype=ruby

  " Rantfile
  au BufRead,BufNewFile [rR]antfile,*.rant         set filetype=ruby

  " IRB config
  au BufRead,BufNewFile .irbrc,irbrc               set filetype=ruby

  " eRuby
  au BufRead,BufNewFile *.erb,*.rhtml              set filetype=eruby

  " Thorfile
  au BufRead,BufNewFile [tT]horfile,*.thor         set filetype=ruby

  " css - preprocessor
  au BufRead,BufNewFile *.less,*.scss,*.sass       set filetype=css syntax=css

  " gnuplot
  au BufRead,BufNewFile *.plt                      set filetype=gnuplot

  " C++
  au BufRead,BufNewFile *.cpp                      set filetype=cpp

  " markdown
  au BufRead,BufNewFile *.md,*.markdown,*.ronn     set filetype=markdown

  " special text files
  au BufRead,BufNewFile *.rtxt         set filetype=html spell
  au BufRead,BufNewFile *.stxt         set filetype=markdown spell

  au BufRead,BufNewFile *.sql        set filetype=pgsql

  au BufRead,BufNewFile *.rl         set filetype=ragel

  au BufRead,BufNewFile *.svg        set filetype=svg

  au BufRead,BufNewFile *.haml       set filetype=haml

  " aura cmp files
  au BufRead,BufNewFile *.cmp        set filetype=html

  " JavaScript
  au BufNewFile,BufRead *.es5        set filetype=javascript
  au BufNewFile,BufRead *.es6        set filetype=javascript
  au BufRead,BufNewFile *.hbs        set syntax=handlebars
  au BufRead,BufNewFile *.mustache   set filetype=mustache
  au BufRead,BufNewFile *.json       set filetype=json syntax=javascript

  " zsh
  au BufRead,BufNewFile *.zsh-theme  set filetype=zsh

  au Filetype gitcommit                setlocal tw=68 spell fo+=t nosi
  au BufNewFile,BufRead COMMIT_EDITMSG setlocal tw=68 spell fo+=t nosi

  " ruby
  au Filetype ruby                   set tw=80

  " allow tabs on makefiles
  au FileType make                   setlocal noexpandtab
  au FileType go                     setlocal noexpandtab

  " set makeprg(depends on filetype) if makefile is not exist
  if !filereadable('makefile') && !filereadable('Makefile')
    au FileType c                    setlocal makeprg=gcc\ %\ -o\ %<
    au FileType cpp                  setlocal makeprg=g++\ %\ -o\ %<
    au FileType sh                   setlocal makeprg=bash\ -n\ %
    au FileType php                  setlocal makeprg=php\ -l\ %
  endif
endif


"--------------------------------------------------------------------------
""" Useful Functions
"------------------------------------------------------------------------
function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

" Toggle between number and relativenumber.
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
        set number
    else
        set relativenumber
    endif
endfunc

" Stripe whitespace.
function! StripWhitespace()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  :%s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfunction

" Multi-purpose tab key. (auto-complete)
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<Tab>"
  else
    return "\<C-p>"
  endif
endfunction

" Strip trailing whitespace.
function! StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

function! CmdLine(str)
  exe "menu Foo.Bar :" . a:str
  emenu Foo.Bar
  unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
  let l:saved_reg = @"
  execute "normal! vgvy"

  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")

  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  elseif a:direction == 'gv'
    call CmdLine("Ack \"" . l:pattern . "\" " )
  elseif a:direction == 'replace'
    call CmdLine("%s" . '/'. l:pattern . '/')
  elseif a:direction == 'f'
    execute "normal /" . l:pattern . "^M"
  endif

  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

" Do not close window, when deleting a buffer.
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction



"----------------------------------------------------------------
""" Plugins
"------------------------------------------------------------
if filereadable(expand("~/.vimrc_bundles"))
  source ~/.vimrc_bundles
endif