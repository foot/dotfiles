set nocompatible

" ----------------------------------------------------------------------------
" MAKE PRETTY + HUD
"
syntax on
colorscheme desert

set showmatch " When a bracket is inserted, briefly jump to the matching one.
set ruler     " Show the line and column number of the cursor position, separated by a comma
set showmode  " If in Insert, Replace or Visual mode put a message on the last line.
set showcmd   " Show (partial) command in status line
set wildmode=list:longest,full " On first tab show all matches and complete to point of differ.
set laststatus=2	"always a status line

" ----------------------------------------------------------------------------
" FILES & STARTUP
"
filetype on           " Enable filetype detection
filetype indent on    " Enable filetype-specific indenting
filetype plugin on    " Enable filetype-specific plugins

" default
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab

au FileType python set textwidth=79 tabstop=4 shiftwidth=4 softtabstop=4 expandtab
au FileType ruby set textwidth=79 tabstop=2 shiftwidth=2 softtabstop=2 expandtab
au FileType javascript set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
au! BufRead,BufNewFile *.json set filetype=javascript
au! BufRead,BufNewFile Capfile set filetype=ruby

" TODO: i <3 python, but do this in vim.
" source a dir specific .vimrc if it exists
python << EOF
import os, vim
if os.path.exists(".vimrc"):
    # avoid loop, do not re-source ~/.vimrc if in ~
    if os.getcwd() != os.path.expanduser('~'):
        vim.command(":so .vimrc")
EOF

" Disable Generation of Backup Files
set nobackup
set noswapfile

" mapleader gotta be set before specifying maps
let mapleader = ","

" ----------------------------------------------------------------------------
" INDENTATION
"
set shiftround " Round indent to multiple of 'shiftwidth'
set autoindent
set smartindent

" ----------------------------------------------------------------------------
" SEARCH
"
set incsearch
set ignorecase
set smartcase

" turn on hlsearch when searching for something explicitly
nnoremap * :set hlsearch<cr>*
nnoremap # :set hlsearch<cr>#
nnoremap / :set hlsearch<cr>/
nnoremap ? :set hlsearch<cr>?
" turn hlsearch OFF
nmap <Leader><Leader> :set hlsearch!<cr>
nmap <Leader>/ :set hlsearch!<cr>
" TODO: turn OFF when using search as a motion
" onoremap / :set nohlsearch<cr>/

" ----------------------------------------------------------------------------
" BUFFERS
"
set hidden " enable persistent undo across buffers / no whinging on :bn when unsaved!

" Quick buffer change/delete
nmap <Leader>n :bn<cr>
nmap <Leader>p :bp<cr>
nmap <Leader>d :bd<cr>
" only for OSX (D == Apple)
" nmap <D-n> :bn<cr> 
" nmap <D-p> :bp<cr>
" nmap <D-d> :bd<cr>

" ----------------------------------------------------------------------------
" MISC
"
" allow <BkSpc> to delete line breaks, beyond the start of the current
" insertion, and over indentations:
set backspace=eol,start,indent

" When typing '#' as the first character in a new line, the indent for
" that line is removed, the '#' is put in the first column.  The indent
" is restored for the next line.  If you don't want this, use this
" mapping:
inoremap # X#

" Q for formatting instead of Ex mode.
noremap Q gqq 

" vim dirs to window hopping.
noremap <C-k> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l
noremap <C-j> <C-W>j

" Cycle through errors
map <f2> :clist<cr>
map <f3> :cprevious<cr>
map <f4> :cnext<cr>
map <f5> :make<cr>

" when don't de-ctrl fast enough.
" TODO: close preview window first if its open.
nmap <c-w><c-c> <c-w>c

" !ctags -R . 
" map <M-c> :TC<CR>

" AWESOME. TODO: make this auto based on whether near ", ', (, [, or <
nmap X ci"

" use CTRL-F for omni completion
imap <C-F> 

" TODO: fixes these two maps up: (so they preserve registers etc)
" display all lines with keyword under cursor and ask which one to jump to
" nmap ,f [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
" map CTRL-L to piece-wise copying of the line above the current one
imap <C-L> @@@<ESC>hhkywjl?@@@<CR>P/@@@<CR>3s

" TODO: make these auto: depending on whether contents of buffer is line or not
" map <Alt-p> and <Alt-P> to paste below/above and reformat
nnoremap <Esc>P  P'[v']=
nnoremap <Esc>p  p'[v']=

" do inline python evals from vimscript
" e.g. let s:dx = EvalPython("abs(-1)") 
" 
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

" ----------------------------------------------------------------------------
" ECLIPSE BLOCK SHIFTING - thnx puyo!
"
imap <M-j> <Esc>:m+<CR>gi
imap <M-k> <Esc>:m-2<CR>gi
vmap <M-j> :m'>+<CR>gv
vmap <M-k> :m'<-2<CR>gv
vmap <M-h> :<<CR>gv
nmap <M-j> mz:m+<CR>`z
nmap <M-k> mz:m-2<CR>`z
vmap <M-l> :><CR>gv

" COMMAND LINE MAPS
" ----------------------------------------------------------------------------
"
" Emacs flavoured command line editing.
cnoremap <M-BS> <C-W>
cnoremap <C-A> <Home>

" For accidental :W instead of :w
cmap W<cr> w<cr>
cmap Wq<cr> wq<cr>
cmap Wqa<cr> wqa<cr>

"
" PLUGIN CONFIGS
" ============================================================================
"
" ----------------------------------------------------------------------------
" Minibuf explorer 
"
" let g:miniBufExplMapCTabSwitchBufs = 1
" let g:miniBufExplUseSingleClick = 1
" let g:miniBufExplMapWindowNavVim = 1
" Vertical minibuf
" let g:miniBufExplVSplit = 20
" let g:miniBufExplSplitBelow=1

" ----------------------------------------------------------------------------
" TagList plugin
"
nnoremap <silent> <F8> :TlistToggle<CR>
" actionscript tags
let tlist_actionscript_settings = 'actionscript;c:class;f:method;p:property;v:variable'
" by default it loads TAGS (caps) files too, which we want to use for etags
set tags=./tags,tags

" ----------------------------------------------------------------------------
" camelCaseWords
"
nmap <silent> <space> <Plug>CamelCaseMotion_w
omap <silent> <space> <Plug>CamelCaseMotion_w
nmap <silent> <bs> <Plug>CamelCaseMotion_b
omap <silent> <bs> <Plug>CamelCaseMotion_b

omap <silent> i<space> <Plug>CamelCaseMotion_iw
vmap <silent> i<space> <Plug>CamelCaseMotion_iw
omap <silent> i<bs> <Plug>CamelCaseMotion_ib
vmap <silent> i<bs> <Plug>CamelCaseMotion_ib 

" ----------------------------------------------------------------------------
" Fuzzy Finder
"
nmap <c-e> :FuzzyFinderTag<cr>
nmap <c-s> :FuzzyFinderBuffer<cr>
nmap <c-f> :FuzzyFinderFile \*\*\/<cr>

" Dont use these modes.
let g:FuzzyFinderOptions = {}
let g:FuzzyFinderOptions.Dir = {'mode_available': 0}
let g:FuzzyFinderOptions.MruFile = {'mode_available': 0}
let g:FuzzyFinderOptions.MruCmd = {'mode_available': 0}
let g:FuzzyFinderOptions.FavFile = {'mode_available': 0}
let g:FuzzyFinderOptions.TaggedFile = {'mode_available': 0}

" Change open key so we're 'pulling down' new file into current window.
let g:FuzzyFinderOptions.Base = {}
let g:FuzzyFinderOptions.Base.key_open = '<c-j>'
let g:FuzzyFinderOptions.Base.key_open_split = '<CR>'

" key_next_mode is already <c-l>, change key_prev_mode to matching <c-h>
let g:FuzzyFinderOptions.Base.key_prev_mode = '<C-h>'

" ----------------------------------------------------------------------------
" snippetsEmu
"
" pretty it up.
let g:snip_start_tag = "‹"
let g:snip_end_tag = "›"
function! HighlightSnips()
     exec "hi snippetEmuJump guibg=grey30"
     exec "syn region snippetEmuJump start=/".g:snip_start_tag."/ end=/".g:snip_end_tag."/"
endfunction
au BufNewFile,BufRead * call HighlightSnips()

" ----------------------------------------------------------------------------
" GIT-AGE HIGHLIGHT
"
noremap <Leader>h :call ToggleAgeHighlight()<cr>

let g:age_highlight_on=0
function! ToggleAgeHighlight()
    if g:age_highlight_on
        exec "syntax on"
    else
        exec "syntax off"
        exec "pyfile ~/.vim/gitage.py"
    end
    let g:age_highlight_on = !g:age_highlight_on
endfunction

