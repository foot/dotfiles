set nocompatible

syntax on
colorscheme desert

set guioptions-=T "get rid of (T)oolbar
set guioptions-=L "get rid of (L)eft scrollbar
set guioptions-=r "get rid of (r)ight scrollbar
set guioptions-=m "get rid of (m)enu bar
set guioptions+=c "no popups, prompt in console instead

" set linespace=1 " 1px between lines
set guifont=Monaco:h10.00 " Looks good on OSX
" set guifont=Monospace\ 8

let mapleader = ","

" ----------------------------------------------------------------------------
" Disable Generation of Backup Files
" actually they are nice but vim is stable and doesn't crash :D
set nobackup
set noswapfile

" ----------------------------------------------------------------------------
" TAB / LINE SIZES
set tabstop=4
set shiftwidth=4
set softtabstop=4 
" set textwidth=79 

filetype plugin indent on "??

au FileType python set textwidth=79 tabstop=4 shiftwidth=4 softtabstop=4 expandtab

au! BufRead,BufNewFile *.json set filetype=javascript
au! BufRead,BufNewFile *.m set filetype=objc
" au FileType ruby set textwidth=79 tabstop=2 shiftwidth=2 softtabstop=2 
" au FileType actionscript set textwidth=158

set expandtab

" ----------------------------------------------------------------------------
" INDENTATION
set shiftround " Round indent to multiple of 'shiftwidth'
set autoindent
set smartindent

" ----------------------------------------------------------------------------
" HUD
set showmatch " When a bracket is inserted, briefly jump to the matching one.
set ruler     " Show the line and column number of the cursor position, separated by a comma
set showmode  " If in Insert, Replace or Visual mode put a message on the last line.
set showcmd   " Show (partial) command in status line
set wildmode=list:longest,full " On first tab show all matches and complete to point of differ.

" ----------------------------------------------------------------------------
" SEARCH
" set hlsearch
nmap <Leader><Leader> :set hlsearch!<cr>
nmap <Leader>/ :set hlsearch!<cr>
set incsearch
set ignorecase
set smartcase

" ----------------------------------------------------------------------------
" COMPLETION
" set completeopt=menu,longest,preview

"
" allow <BkSpc> to delete line breaks, beyond the start of the current
" insertion, and over indentations:
set backspace=eol,start,indent

" When typing '#' as the first character in a new line, the indent for
" that line is removed, the '#' is put in the first column.  The indent
" is restored for the next line.  If you don't want this, use this
" mapping:
inoremap # X#

" Y behaves like D and C instead of default behaviour (Y == yy)
" noremap Y y$

" Q for formatting instead of Ex mode.
noremap Q gqq

" enable persistent undo across buffers / no whinging on :bn when unsaved!
set hidden

" minibuf
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplUseSingleClick = 1
"let g:miniBufExplMapWindowNavVim = 1
" Vertical minibuf
" let g:miniBufExplVSplit = 20
" let g:miniBufExplSplitBelow=1

noremap <C-H> <C-W>h
noremap <C-L> <C-W>l
noremap <C-j> <C-W>j

" TagList plugin
" let Tlist_File_Fold_Auto_Close = 1
nnoremap <silent> <F8> :TlistToggle<CR>
" actionscript tags
let tlist_actionscript_settings = 'actionscript;c:class;f:method;p:property;v:variable'
" by default it loads TAGS (caps) files which we want to use for etags
set tags=./tags,tags 

" Cycle through errors
map <f2> :clist<cr>
map <f3> :cprevious<cr>
map <f4> :cnext<cr>
map <f5> :make<cr>
" <f8>: Tlist expl.
map <f9> :NERDTreeToggle<cr>

" Quick buffer change/delete
nmap <Leader>n :bn<cr>
nmap <Leader>p :bp<cr>
nmap <Leader>d :bd<cr>
" nmap <Leader>x :close<cr>

" only for OSX D==Apple
nmap <D-n> :bn<cr> 
nmap <D-p> :bp<cr>
nmap <D-d> :bd<cr>

" ----------------------------------------------------------------------------
" map <SPACE> => camelCaseWords
nmap <space> ,w
omap <space> ,w
nmap <bs> ,b
omap <bs> ,b


"noremap <C-J> /
noremap <C-K> :FuzzyFinderTag<cr>
"nmap <c-space> :FuzzyFinderTag<cr>
"nmap <cr> :FuzzyFinderTag<cr>
nmap <c-s> :FuzzyFinderBuffer<cr>
nmap <c-f> :FuzzyFinderFile<cr>
let g:FuzzyFinder_KeySwitchMode = '<TAB>'
let g:FuzzyFinderOptions = {
\   'file' : {
\     'abbrev_map' : {
\       "tf " : ["", "**/"]
\     },
\     'initial_text' : "tf "
\   }
\ }

" Jump to tags quickly
" <C-S> is mapped by incBufSearch
" nmap <C-S><C-S> :tag 

" for accidental :W instead of :w
cmap W<cr> w<cr>
cmap Wq<cr> wq<cr>
cmap Wqa<cr> wqa<cr>

" for AS3 client
iabbr trace Log.debug

" Select everything
noremap <Leader>a ggVG

" !ctags -R . 
map <M-c> :TC<CR>

nmap X ci"
"
" map ,f to display all lines with keyword under cursor and ask which one to
" jump to
nmap ,f [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
" map CTRL-L to piece-wise copying of the line above the current one
imap <C-L> @@@<ESC>hhkywjl?@@@<CR>P/@@@<CR>3s

" use CTRL-F for omni completion
imap <C-F> 

" map <Alt-p> and <Alt-P> to paste below/above and reformat
nnoremap <Esc>P  P'[v']=
nnoremap <Esc>p  p'[v']=

let g:NERDTreeChDirMode = 0

" i <3 python, source a dir specific .vimrc if it exists
python << EOF
import os, vim
if os.path.exists(".vimrc"):
    # avoid loop, do not re-source ~/.vimrc if in ~
    if os.getcwd() != os.path.expanduser('~'):
        vim.command(":so .vimrc")
EOF

" ----------------------------------------------------------------------------
" PRETTY up snippetsEmu
let g:snip_start_tag = ""
let g:snip_end_tag = ""
function! HighlightSnips()
     exec "hi snippetEmuJump guibg=grey30"
     exec "syn region snippetEmuJump start=/".g:snip_start_tag."/ end=/".g:snip_end_tag."/"
endfunction
au BufNewFile,BufRead * call HighlightSnips()

" do inline python evals from vimscript
" e.g. let s:dx = EvalPython("abs(-1)") 
" 
if has('python')
    function! EvalPython(py_str)
        let g:eval_python_tmp=a:py_str
python << EOF
import vim
py_str = vim.eval("g:eval_python_tmp")
return_value = eval(py_str)
vim.command("let g:eval_python_tmp_return=%r" % (return_value,))
EOF
        return g:eval_python_tmp_return
    endfunction
endif

" turn on hlsearch when searching for something
nnoremap * :set hlsearch<cr>*
nnoremap # :set hlsearch<cr>#
nnoremap / :set hlsearch<cr>/
nnoremap ? :set hlsearch<cr>?
nnoremap <silent> <a-/> :nohlsearch<CR>
map 0 ^

" turn hlsearch OFF when using search as a motion: TODO
" onoremap / :set nohlsearch<cr>/

let g:ECuseAltKeys = 1

