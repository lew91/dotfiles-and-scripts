" ---------------------------------------
""" Basic Setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"=====[  Make Vim more useful. ]==================

set nocompatible

"=====[ mapleader mappings ]==================

let mapleader = ','

"=====[ Set the default shell.]================

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

"When the type of shell script is /bin/sh, assume a POSIX-compatible 
"shell for syntax highlighting purposes. 

let g:is_posix = 1

"=====[  Tell vim to use the .vim path first. ]===============

set runtimepath=~/.vim,$VIMRUNTIME

"=====[  Optimize for fast terminal connections ]==============

set ttyfast

"====[  Enable filetype dectection and ft specific plugin/indent ]=============

filetype plugin indent on


"=====[ Convert to Unicode defaults ]===============================

setglobal termencoding=utf-8 fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,lattin1,cp932,sjis,utf-16le,euc-jp
scriptencoding utf-8
set encoding=utf-8

autocmd BufNewFile,BufRead  *   try
autocmd BufNewFile,BufRead  *       set encoding=utf-8
autocmd BufNewFile,BufRead  *   endtry

"None word dividers.

set isk+=_,$,@,%,#,-

"Try to detect file formats. Unix for new files and autodetect for the rest. 

set fileformats=unix,dos,mac


"----------------------------------------------------------------
""" Plugins
"------------------------------------------------------------
if filereadable(expand("~/.vimrc_plug"))
  source ~/.vimrc_plug
endif


"------------------------------------------------------
""" Vim UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enhance command-line completion.
if exists("+wildmenu")
  set wildmenu
  " type of wildmenu
  set wildmode=longest:full,list:full
endif

"Avoid garbled characters in Chinese language windows OS 
let $LANGE='en'
set langmenu=en 
source $VIMRUNTIME/delmenu.vim 
source $VIMRUNTIME/menu.vim 

"Ignore compiled files 
set wildignore=*.o,*~,*.pyc 
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\* 
else 
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

" NO modeline
set nomodeline
set modelines=0

" Enable per-directory .vimrc files.
set exrc

" Disable unsafe commands.
set secure

" For regular expressions turn magic on
set magic


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
set number                                                        " show line numbers
set showmatch                                                     " show matching bracket (briefly jump)
set showcmd                                                       " show typed command in status bar
"set laststatus=2                                                  " use 2 lines for the status bar
set matchtime=2                                                   " show matching bracket for 0.2 seconds
set matchpairs+=<:>,«:»,｢:｣                                              " specially for html
set splitbelow                                                    "put the preview window bottom
"if exists("&relativenumber")
"    set relativenumber
"    au BufReadPost * set relativenumber
"endif                                                             "show relative line number

" Don't add empty newlines at the end of files
"set binary
set noeol

au CompleteDone * pclose


"=====[  Default Indentation ]==============================

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

" Enable syntax highlighting
syntax enable 

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

try
    colorscheme desert
catch
endtry

set background=dark

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions-=e
    set guioptions-=r 
    set guioptions-=R 
    set guioptions-=l 
    set guioptions-=L 
    set t_Co=256
    set guitablabel=%M\ %t
endif

" Set font according to system 
if has("mac") || has("macunix")
    set gfn=Hack:h12,Source\ Code\ Pro:h12,Menlo:h12
elseif has("win16") || has("win32")
    set gfn=Source\ code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has("gui_gtk2")
    set gfn=Hack\ 13,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11 
elseif has("linux")
    set gfn=Hack\ 13,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11 
elseif has("unix")
    set gfn=Monospace\ 11 
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8


"======[ Fix colourscheme for 256 colours ]============================

highlight Visual       ctermfg=Yellow ctermbg=26    " 26 = Dusty blue background
highlight SpecialKey   cterm=bold ctermfg=Blue

"======[ highlight popup ]=======================

" Make the completion popup look menu-ish on a Mac...
highlight  Pmenu        ctermbg=white   ctermfg=black
highlight  PmenuSel     ctermbg=blue    ctermfg=white   cterm=bold
highlight  PmenuSbar    ctermbg=grey    ctermfg=grey
highlight  PmenuThumb   ctermbg=blue    ctermfg=blue

" Make diffs less glaringly ugly...
highlight DiffAdd     cterm=bold ctermfg=green     ctermbg=black
highlight DiffChange  cterm=bold ctermfg=grey      ctermbg=black
highlight DiffDelete  cterm=bold ctermfg=black     ctermbg=black
highlight DiffText    cterm=bold ctermfg=magenta   ctermbg=black

" Grammar checking
highlight GRAMMARIAN_ERRORS_MSG   ctermfg=red   cterm=bold
highlight GRAMMARIAN_CAUTIONS_MSG ctermfg=white cterm=bold

"=====[ Highlight cursor ]===================

" Inverse highlighting for cursor...
highlight CursorInverse ctermfg=black ctermbg=white

" Set up highlighter at high priority (i.e. 99)
call matchadd('CursorInverse', '\%#.', 99)

"=======[ Prettier tabline ]============================================

highlight Tabline      cterm=underline       ctermfg=40     ctermbg=22
highlight TablineSel   cterm=underline,bold  ctermfg=white  ctermbg=28
highlight TablineFill  cterm=NONE            ctermfg=black  ctermbg=black

"---------------------------------------------------------
""" Files Editing
"---------------------------------------------------------
"====[ Use persistent undo ]=================

if has('persistent_undo')
    " Save all undo files in a single location (less messy, more risky)...
    set undodir=$HOME/.VIM_UNDO_FILES

    " Save a lot of back-history...
    set undolevels=5000

    " Actually switch on persistent undo
    set undofile

endif

" Turn backup off, since most stuff is in SVN, git etc. anyway...
set nobackup
set nowb
set noswapfile

"====[ Toggle visibility of naughty characters ]============

" Make naughty characters visible...
" (uBB is right double angle, uB7 is middle dot)
"set lcs=tab:»·,trail:␣,nbsp:˷
"highlight InvisibleSpaces ctermfg=Black ctermbg=Black
"call matchadd('InvisibleSpaces', '\S\@<=\s\+\%#\ze\s*$')

"augroup VisibleNaughtiness
"    autocmd!
"    autocmd BufEnter  *       set list
"    autocmd BufEnter  *       set list
"    autocmd BufEnter  *.txt   set nolist
"    autocmd BufEnter  *.vp*   set nolist
"    autocmd BufEnter  *       if !&modifiable
"    autocmd BufEnter  *           set nolist
"    autocmd BufEnter  *       endif
"augroup END

"====[ Set up smarter search behaviour ]=======================

set incsearch       "Lookahead as search pattern is specified
set ignorecase      "Ignore case in all searches...
set smartcase       "...unless uppercase letters used

" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
map <space> /
map <C-space> ?

set hlsearch        "Highlight all matches
highlight clear Search
highlight       Search    ctermfg=White  ctermbg=Black  cterm=bold
highlight    IncSearch    ctermfg=White  ctermbg=Red    cterm=bold

function! TrimTrailingWS ()
    if search('\s\+$', 'cnw')
        :%s/\s\+$//g
    endif
endfunction

" Ignore whitespace in vimdiff.
if &diff
  set diffopt+=iwhite
endif

"=====[ Diff against disk ]==========================================

map <silent> zd :silent call DC_DiffChanges()<CR>

" Change the fold marker to something more useful
function! DC_LineNumberOnly ()
    if v:foldstart == 1 && v:foldend == line('$')
        return '.. ' . v:foldend . '  (No difference)'
    else
        return '.. ' . v:foldend
    endif
endfunction

" Track each buffer's initial state
augroup DC_TrackInitial
    autocmd!
    autocmd BufReadPost,BufNewFile  *   if !exists('b:DC_initial_state')
    autocmd BufReadPost,BufNewFile  *       let b:DC_initial_state = getline(1,'$')
    autocmd BufReadPost,BufNewFile  *   endif
augroup END

highlight DC_DEEMPHASIZED ctermfg=grey

function! DC_DiffChanges ()
    diffthis
    highlight Normal ctermfg=grey
    let initial_state = b:DC_initial_state
    set diffopt=context:2,filler,foldcolumn:0
"    set fillchars=fold:ÃÂ 
    set foldcolumn=0
    setlocal foldtext=DC_LineNumberOnly()
    set number

"    aboveleft vnew
    belowright vnew
    normal 0
    silent call setline(1, initial_state)
    diffthis
    set diffopt=context:2,filler,foldcolumn:0
"    set fillchars=fold:ÃÂ 
    set foldcolumn=0
    setlocal foldtext=DC_LineNumberOnly()
    set number

    nmap <silent><buffer> zd :diffoff<CR>:q!<CR>:set diffopt& fillchars& number& foldcolumn=0<CR>:set nodiff<CR>:highlight Normal ctermfg=NONE<CR>
endfunction

" Strip trailing whitespaces automatically when saving files of certain type.
if has("autocmd")
  autocmd BufWritePre *.py,*.js,*.php,*.gpx,*.rb,*.tpl :call StripTrailingWhitespaces()
endif


"=====[ Miscellaneous features (mainly options) ]=====================

set title           "Show filename in titlebar of window
set titleold=
"set titlestring=%t%(\ %M%)%(\ (%{expand(\"%:~:.:h\")})%)%(\ %a%)
set title titlestring=

set nomore          "Don't page long listings

set cpoptions-=a    "Don't set # after a :read

set autowrite       "Save buffer automatically when changing files
set autoread        "Always reload buffer when external changes detected

"           +--Disable hlsearch while loading viminfo
"           | +--Remember marks for last 500 files
"           | |    +--Remember up to 10000 lines in each register
"           | |    |      +--Remember up to 1MB in each register
"           | |    |      |     +--Remember last 1000 search patterns
"           | |    |      |     |     +---Remember last 1000 commands
"           | |    |      |     |     |
"           v v    v      v     v     v
set viminfo=h,'500,<10000,s1000,/1000,:1000


set wildmode=list:longest,full      "Show list of completions
                                    "  and complete as much as possible,
                                    "  then iterate full completions

set infercase                       "Adjust completions to match case

set noshowmode                      "Suppress mode change messages

set updatecount=10                  "Save buffer every 10 chars typed


" Keycodes and maps timeout in 3/10 sec...
set timeout timeoutlen=300 ttimeoutlen=300

" "idleness" is 2 sec
set updatetime=2000

set scrolloff=2                     "Scroll when 3 lines from top/bottom

"=====[ Search folding ]=====================

" Don't start new buffers folded
set foldlevelstart=99

" Highlight folds
highlight Folded  ctermfg=cyan ctermbg=black

" Toggle special folds on and off...
nmap <silent> <expr>  zz  FS_ToggleFoldAroundSearch({'context':1})
nmap <silent> <expr>  zc  FS_ToggleFoldAroundSearch({'hud':1})


" Heads-up on function names (in Vim and Perl)...

let g:HUD_search = {
\   'vim':  { 'list':     [ { 'start': '^\s*fu\%[nction]\>!\?\s*\w\+.*',
\                             'end':   '^\s*endf\%[unction]\>\zs',
\                           },
\                           { 'start': '^\s*aug\%[roup]\>!\?\s*\%(END\>\)\@!\w\+.*',
\                             'end':   '^\s*aug\%[roup]\s\+END\>\zs',
\                           },
\                         ],
\              'default': '"file " . expand("%:~:.")',
\           },
\
\   'perl': { 'list':    [ { 'start': '\_^\s*\zssub\s\+\w\+.\{-}\ze\s*{\|^__\%(DATA\|END\)__$',
\                            'end':   '}\zs',
\                          },
\                          { 'start': '\_^\s*\zspackage\s\+\w\+.\{-}\ze\s*{',
\                            'end':   '}\zs',
\                          },
\                          { 'start': '\_^\s*\zspackage\s\+\w\+.\{-}\ze\s*;',
\                            'end':   '\%$',
\                          },
\                        ],
\             'default': '"package main"',
\          },
\ }

function! HUD ()
    let target = get(g:HUD_search, &filetype, {})
    let name = "'????'"
    if !empty(target)
        let name = eval(target.default)
        for nexttarget in target.list
            let [linestart, colstart] = searchpairpos(nexttarget.start, '', nexttarget.end, 'cbnW')
            if linestart
                let name = matchstr(getline(linestart), nexttarget.start)
                break
            endif
        endfor
    endif

    if line('.') <= b:FS_DATA.context
        return '⎺⎺⎺⎺⎺\ ' . name . ' /⎺⎺⎺⎺⎺' . repeat('⎺',200)
    else
        return '⎽⎽⎽⎽⎽/ ' . name . ' \⎽⎽⎽⎽⎽' . repeat('⎽',200)
    endif
endfunction

nmap <silent> <expr>  zh  FS_ToggleFoldAroundSearch({'hud':1, 'folds':'HUD()', 'context':3})


" Show only sub defns (and maybe comments)...
let perl_sub_pat = '^\s*\%(sub\|func\|method\|package\)\s\+\k\+'
let vim_sub_pat  = '^\s*fu\%[nction!]\s\+\k\+'
augroup FoldSub
    autocmd!
    autocmd BufEnter * nmap <silent> <expr>  zp  FS_FoldAroundTarget(perl_sub_pat,{'context':1})
    autocmd BufEnter * nmap <silent> <expr>  za  FS_FoldAroundTarget(perl_sub_pat.'\zs\\|^\s*#.*',{'context':0, 'folds':'invisible'})
    autocmd BufEnter *.vim,.vimrc nmap <silent> <expr>  zp  FS_FoldAroundTarget(vim_sub_pat,{'context':1})
    autocmd BufEnter *.vim,.vimrc nmap <silent> <expr>  za  FS_FoldAroundTarget(vim_sub_pat.'\\|^\s*".*',{'context':0, 'folds':'invisible'})
    autocmd BufEnter * nmap <silent> <expr>             zv  FS_FoldAroundTarget(vim_sub_pat.'\\|^\s*".*',{'context':0, 'folds':'invisible'})
augroup END

" Show only 'use' statements
nmap <silent> <expr>  zu  FS_FoldAroundTarget('\(^\s*\(use\\|no\)\s\+\S.*;\\|\<require\>\s\+\S\+\)',{'context':1})


"=====[ Interface with ag ]======================

set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

" Also use ag in GVI...
let g:GVI_use_ag = 1


"=====[ Decute startify ]================

let g:startify_custom_header = []


"=====[ Configure change-tracking ]========

let g:changes_hl_lines=1
let g:changes_verbose=0
let g:changes_autocmd=1


"=====[ Make netrw more instantly useful ]============

let g:netrw_sort_by        = 'time'
let g:netrw_sort_direction = 'reverse'
let g:netrw_banner         = 0
let g:netrw_liststyle      = 3
let g:netrw_browse_plit   = 3
let g:netrw_fastbrowse     = 1
let g:netrw_sort_by        = 'name'
let g:netrw_sort_direction = 'normal'



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

" Delete trailing whitespace one save, usefule for some filetypes
function! CleanExtraSpace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e 
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*coffee :call CleanExtraSpace()
endif

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


"======[ Order-preserving uniqueness ]=========================

" Normalize the whitespace in a string...
function! TrimWS (str)
    " Remove whitespace fore and aft...
    let trimmed = substitute(a:str, '^\s\+\|\s\+$', '', 'g')

    " Then condense internal whitespaces...
    return substitute(trimmed, '\s\+', ' ', 'g')
endfunction

" Reduce a range of lines to only the unique ones, preserving order...
function! Uniq (...) range
    " Ignore whitespace differences, if asked to...
    let ignore_ws_diffs = len(a:000)

    " Nothing unique seen yet...
    let seen = {}
    let uniq_lines = []

    " Walk through the lines, remembering only the hitherto unseen ones...
    for line in getline(a:firstline, a:lastline)
        let normalized_line = '>' . (ignore_ws_diffs ? TrimWS(line) : line)
        if !get(seen,normalized_line)
            call add(uniq_lines, line)
            let seen[normalized_line] = 1
        endif
    endfor

    " Replace the range of original lines with just the unique lines...
    exec a:firstline . ',' . a:lastline . 'delete'
    call append(a:firstline-1, uniq_lines)
endfunction

"====[ Regenerate help tags when directly editing a help file ]=================

augroup HelpTags
    au!
    autocmd BufWritePost ~/.vim/doc/*   :helptags ~/.vim/doc
augroup END
