set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'kevinw/pyflakes-vim'
Bundle 'mileszs/ack.vim'
" Bundle 'Lokaltog/vim-easymotion'
" Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'sjl/gundo.vim'
Bundle 'vim-scripts/Color-Sampler-Pack'

" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'camelcasemotion'
" Bundle 'Railscasts Theme'
"
" non github repos
Bundle 'git://git.wincent.com/command-t.git'
Bundle 'http://repo.or.cz/r/vcscommand.git'
" ...

filetype plugin indent on     " required! 

set t_Co=256


" ----------------------------------------------------------------------------
" MAKE PRETTY + HUD
"
syntax on
set bg=dark
" colorscheme desert256

set showmatch " When a bracket is inserted, briefly jump to the matching one.
set ruler     " Show the line and column number of the cursor position, separated by a comma
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set showmode  " If in Insert, Replace or Visual mode put a message on the last line.
set showcmd   " Show (partial) command in status line
set wildmode=list:longest,full " On first tab show all matches and complete to point of differ.
set laststatus=2	"always a status line

" default
set tabstop=4 shiftwidth=4

augroup init
    au FileType python setlocal textwidth=79 tabstop=4 shiftwidth=4
    au FileType ruby setlocal textwidth=79 tabstop=2 shiftwidth=2 softtabstop=2 expandtab
    au FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2
    au FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2
    au FileType coffee setlocal textwidth=79 tabstop=2 shiftwidth=2 softtabstop=2 expandtab

    au BufNewFile,BufRead *.as setlocal filetype=actionscript 
    au BufRead,BufNewFile *.json setlocal filetype=javascript
    au BufRead,BufNewFile Capfile setlocal filetype=ruby
augroup END

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
nmap <Leader>n :cn<cr>
nmap <Leader>p :cp<cr>
nmap <Leader>d :bd<cr>
" only for OSX (D == Apple)
" nmap <D-n> :bn<cr> 
" nmap <D-p> :bp<cr>
" nmap <D-d> :bd<cr>

" DISABLE THIS FOR THE MO! TEST OUT losing focus as save instead
" nmap <cr> :w<cr>

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
" imap <C-L> <esc>kywjpi

" TODO: make these auto: depending on whether contents of buffer is line or not
" map <Alt-p> and <Alt-P> to paste below/above and reformat
nnoremap <Esc>P  P'[v']=
nnoremap <Esc>p  p'[v']=

" Rebuild tags file
nmap <M-c> :!ctags -R .

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

" git blame on visual block
" vmap <Leader>ga :<C-U>!git blame <C-R>=expand("%") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>
vmap <Leader>sa :<C-U>!svn blame <C-R>=expand("%") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

nmap 0 ^

" ----------------------------------------------------------------------------
" ECLIPSE BLOCK SHIFTING - thnx puyo!
"
imap <M-j> <Esc>:m+<CR>gi
imap <M-k> <Esc>:m-2<CR>gi
imap <M-h> <Esc>:<<CR>gi
imap <M-l> <Esc>:><CR>gi

vmap <M-j> :m'>+<CR>gv
vmap <M-k> :m'<-2<CR>gv
vmap <M-h> :<<CR>gv
vmap <M-l> :><CR>gv

nmap <M-j> mz:m+<CR>`z
nmap <M-k> mz:m-2<CR>`z
nmap <M-h> <<
nmap <M-l> >>

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

cmap w!! %!sudo tee > /dev/null %

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
vmap <silent> <space> <Plug>CamelCaseMotion_w

nmap <silent> <bs> <Plug>CamelCaseMotion_b
omap <silent> <bs> <Plug>CamelCaseMotion_b
vmap <silent> <bs> <Plug>CamelCaseMotion_b

omap <silent> i<space> <Plug>CamelCaseMotion_iw
vmap <silent> i<space> <Plug>CamelCaseMotion_iw
omap <silent> i<bs> <Plug>CamelCaseMotion_ib
vmap <silent> i<bs> <Plug>CamelCaseMotion_ib 

" ----------------------------------------------------------------------------
" Fuzzy Finder
"
nmap <c-e> :FufTag<cr>
nmap <c-s> :FufBuffer<cr>
nmap <c-f> :FufFile **/<cr>
nmap <c-q> :FufQuickfix<cr>
nmap <c-/> :FufLine<cr>

" let g:fuzzy_ignore = "vendor/*;lib/paris-cli/*;.git/*;flash-widget/*"
" let g:fuzzy_enumerating_limit = 20

let g:fuf_abbrevMap = {
        \   "VSP$ " : [
        \     "~/workspace/vsp/**/"
        \   ],
        \ }

" let g:FuzzyFinderOptions.Tag = { 'matching_limit': 20 }
let g:fuf_modesDisable = [
        \   'dir', 'mrufile', 'mrucmd',
        \   'bookmark', 'taggedfile',
        \   'jumplist', 'changelist', 'help',
        \   'givenfile', 'givendir', 'givencmd',
        \   'callbackfile', 'callbackitem',
        \ ]

" Change open key so we're 'pulling down' new file into current window.
let g:fuf_keyOpen = '<c-j>'
let g:fuf_keyOpenSplit = '<CR>'

" the other modes.
let g:fuf_keyNextMode = '<c-l>'
let g:fuf_keyPrevMode = '<c-h>'
let g:fuf_keyPreview = '<c-k>'

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
augroup highlight-snips
    au BufNewFile,BufRead * call HighlightSnips()
augroup END

" ----------------------------------------------------------------------------
" GIT-AGE HIGHLIGHT
"
noremap <Leader>h :call ToggleAgeHighlight()<cr>

let g:age_highlight_on=0
function! ToggleAgeHighlight()
    if g:age_highlight_on
        exec "syntax on"
    else
        " exec "syntax off"
        exec "pyfile ~/.vim/gitage.py"
    end
    let g:age_highlight_on = !g:age_highlight_on
endfunction

""""""""""""""""""""""""""""""
" => Visual
""""""""""""""""""""""""""""""
" From an idea by Michael Naumann (via xpaulbettsx)
function! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"
  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  else
    execute "normal /" . l:pattern . "^M"
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endfunction
 
"Basically you press * or # to search for the current selection !! Really useful
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

let g:ackprg="ack-grep -H --nocolor --nogroup --column"

if has("cscope")
	set csprg=/usr/bin/cscope
	set csto=0
	set cst
	set nocsverb
	" add any database in current directory
	if filereadable("cscope.out")
		cs add cscope.out
	" else add database pointed to by environment
	elseif $CSCOPE_DB != ""
		cs add $CSCOPE_DB
	endif
	set csverb
endif

nmap <C-Space>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-Space>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-Space>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-Space>d :cs find d <C-R>=expand("<cword>")<CR><CR>

" fugitive
nmap <leader>gs :Gstatus<cr>
" nmap <leader>gc :Gcommit<cr>
vmap <leader>ga :Gblame<cr>
nmap <leader>ga :Gblame<cr>
nmap <leader>gl :Glog<cr>
nmap <leader>gd :Gdiff<cr>

" write on loss of focus.
au FocusLost * :wa
" try no shift for a bit.
nnoremap ; :

" 7.3 stuff.
set relativenumber
set undodir=/home/simon/.vim/undodir
set undofile

