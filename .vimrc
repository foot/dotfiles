call plug#begin('~/.vim/plugged')

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
" set rtp+=~/.vim/Plug/Vundle.vim
set rtp+=/usr/local/opt/fzf
" call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
" Plugin 'VundleVim/Vundle.vim'

" My Bundles here:
"
" original repos on github
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-commentary'
" Plug 'scrooloose/syntastic'
" Plug 'neomake/neomake'
" Plug 'pmsorhaindo/syntastic-local-eslint.vim'
" Plug 'sbdchd/neoformat'
Plug 'mileszs/ack.vim'
Plug 'w0rp/ale'
" Plug 'Lokaltog/vim-easymotion'
" Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
" Plug 'sjl/gundo.vim'
Plug 'simnalamburt/vim-mundo'
Plug 'vim-scripts/Color-Sampler-Pack'
Plug 'flazz/vim-colorschemes'
" Plug 'groenewege/vim-less.git'

Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'

" Plug 'othree/yajs.vim'
" Plug 'styled-components/vim-styled-components'
" Plug 'mxw/vim-jsx'
Plug 'hail2u/vim-css3-syntax'
Plug 'leafgarland/typescript-vim'

Plug 'othree/csscomplete.vim'
" Plug 'hallettj/jslint.vim'
" Plug 'kchmck/vim-coffee-script'
" Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
" Plug 'msanders/snipmate.vim'
Plug 'digitaltoad/vim-jade'
" Plug 'tpope/vim-haml'
" Plug 'hynek/vim-python-pep8-indent'
" Plug 'ciaranm/detectindent'
Plug 'lepture/vim-jinja'
Plug 'bling/vim-airline'
Plug 'ludovicchabant/vim-lawrencium'
Plug 'embear/vim-localvimrc'
Plug 'slim-template/vim-slim'


" Plug 'Shougo/unite.vim"
" Plug 'Shougo/vimproc.vim'

" Plug 'safetydank/vim-gitgutter'
" Plug 'mfukar/robotframework-vim'
" Plug 'marijnh/tern_for_vim'
" Plug 'junkblocker/patchreview-vim'

" vim-scripts repos
" Plug 'L9'
" Plug 'FuzzyFinder'
Plug 'bkad/CamelCaseMotion'
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-fireplace'
Plug 'venantius/vim-cljfmt'
" Plug 'Railscasts Theme'
" Plug 'mitermayer/vim-prettier'
"
" non github repos
" Plug 'git://git.wincent.com/command-t.git'
" Plug 'http://repo.or.cz/r/vcscommand.git'
" ...

Plug 'fatih/vim-go'

" Plug 'scrooloose/nerdtree.git'
" Plug "vim-scripts/logstash.vim"
Plug 'vim-scripts/paredit.vim'
" Plug 'szw/vim-tags'
" Plug 'grassdog/tagman.vim'
Plug 'ntpeters/vim-better-whitespace'

"Markdown
Plug 'tpope/vim-markdown'
Plug 'chriskempson/base16-vim'

" Plug 'suan/vim-instant-markdown'

" call vundle#end()            " required
call plug#end()

filetype plugin indent on    " required

" ----------------------------------------------------------------------------
" MAKE PRETTY + HUD
"
" syntax on
set t_Co=256
set background=dark
" set termguicolors
let base16colorspace=256
colorscheme base16-tomorrow-night

" set showmatch " When a bracket is inserted, briefly jump to the matching one.
" set ruler     " Show the line and column number of the cursor position, separated by a comma
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P
set showmode  " If in Insert, Replace or Visual mode put a message on the last line.
set showcmd   " Show (partial) command in status line
set wildmode=list:longest,full " On first tab show all matches and complete to point of differ.
" set laststatus=2	"always a status line
set list

augroup init
    au FileType python setlocal textwidth=79 tabstop=4 shiftwidth=4 softtabstop=4 expandtab
    au FileType ruby setlocal textwidth=79 tabstop=2 shiftwidth=2 softtabstop=2 expandtab
    au FileType javascript setlocal textwidth=99 tabstop=2 shiftwidth=2 softtabstop=2 expandtab
    au FileType text setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
    au FileType yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2
    au FileType coffee setlocal textwidth=79 tabstop=2 shiftwidth=2 softtabstop=2
    au FileType html setlocal tabstop=2 shiftwidth=2 softtabstop=2
    au FileType scss setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
    au FileType less setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
    au FileType jade setlocal tabstop=2 shiftwidth=2 softtabstop=2

    " Format the js!
    " autocmd FileType javascript set formatprg=prettier\ --stdin\ --single-quote\ --trailing-comma=all
    " autocmd BufWritePre *.js Neoformat
    " autocmd BufWritePre *.jsx Neoformat
    " au BufWritePost *.coffee silent CoffeeMake! -b | cwindow | redraw!

    " autocmd! BufWritePost * Neomake
    au BufNewFile,BufRead *.slim setlocal filetype=slim

    au BufNewFile,BufRead *.as setlocal filetype=actionscript
    au BufRead,BufNewFile *.json setlocal filetype=javascript
    au BufNewFile,BufRead *.jsx setlocal filetype=javascript.jsx

    au BufRead,BufNewFile *.scss setlocal filetype=scss
    au BufRead,BufNewFile *.cljs setlocal filetype=clojure
    au BufRead,BufNewFile *.boot setlocal filetype=clojure
    au BufRead,BufNewFile Capfile setlocal filetype=ruby
    au BufRead,BufNewFile Vagrantfile setlocal filetype=ruby

    " autocmd BufWritePre *.js :normal gggqG
augroup END

" Disable Generation of Backup Files
" set nobackup
set noswapfile

" mapleader gotta be set before specifying maps
let mapleader = ","

" ----------------------------------------------------------------------------
" INDENTATION
"
" set shiftround " Round indent to multiple of 'shiftwidth'
" set autoindent
set smartindent

" ----------------------------------------------------------------------------
" SEARCH
"
" set incsearch
set ignorecase
set smartcase

" turn on hlsearch when searching for something explicitly
nnoremap * :set hlsearch<cr>*
nnoremap # :set hlsearch<cr>#
" nnoremap / :set hlsearch<cr>/
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
noremap <C-h> <C-W>h
noremap <C-l> <C-W>l
noremap <C-j> <C-W>j

" Cycle through errors
map <f2> :clist<cr>
map <f3> :cprevious<cr>
map <f4> :cnext<cr>

" when don't de-ctrl fast enough.
" TODO: close preview window first if its open.
nmap <c-w><c-c> <c-w>c

" !ctags -R .
" map <M-c> :TC<CR>

" AWESOME. TODO: make this auto based on whether near ", ', (, [, or <
nmap X ci"

" use CTRL-F for omni completion
" imap <C-F> 

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
set tags=tags

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
nmap <c-e> :Tags<cr>
nmap <c-s> :Buffers<cr>
nmap <c-f> :Files<cr>
" nmap <c-a> :History<cr>
" let g:ctrlp_map = '<c-f>'
" let g:ctrlp_cmd = 'CtrlPMixed'
" let g:ctrlp_custom_ignore = 'bower_components$\|node_modules$\|env$\|.*\.pyc$\|\.hg$\|\.git$'
" let g:ctrlp_root_markers = ['.ctrlp']
" let g:ctrlp_prompt_mappings = {
    " \ 'PrtSelectMove("j")':   ['<c-n>', '<down>'],
    " \ 'PrtSelectMove("k")':   ['<c-p>', '<up>'],
    " \ 'PrtHistory(-1)':       [],
    " \ 'PrtHistory(1)':        [],
    " \ 'AcceptSelection("e")': ['<cr>', '<c-j>', '<2-LeftMouse>'],
    \ }
" let g:ctrlp_max_depth = 10
" let g:ctrlp_max_files = 50000
" let g:ctrlp_follow_symlinks = 0
" let g:ctrlp_user_command = 'ag --nogroup --nobreak --noheading --nocolor -g "" %s '


" let g:fuf_coveragefile_exclude = '\v\~$|\.(o|exe|dll|bak|orig|swp)$|(^|[/\\])(\.hg|\.git|\.bzr|env|env-osx|build|pweb/static/extjs)($|[/\\])'
" let g:fuzzy_ignore = "vendor/*;lib/paris-cli/*;.git/*;flash-widget/*"
" let g:fuzzy_enumerating_limit = 20

" Change open key so we're 'pulling down' new file into current window.
" let g:fuf_keyOpen = '<C-j>'
" let g:fuf_keyOpenSplit = '<CR>'

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
" noremap <Leader>h :call ToggleAgeHighlight()<cr>

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

let g:ackprg="ack -H --nocolor --nogroup --column"

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

function! s:HgBlame()
    let fn = expand('%:p')

    wincmd v
    wincmd h
    edit __hgblame__
    vertical resize 28

    setlocal scrollbind winfixwidth nolist nowrap nonumber buftype=nofile ft=none

    normal ggdG
    execute "silent r!hg blame -undq " . fn
    normal ggdd
    execute ':%s/\v:.*$//'

    wincmd l
    setlocal scrollbind
    syncbind
endf
command! -nargs=0 HgBlame call s:HgBlame()
nnoremap <leader>ga :HgBlame<cr>

" fugitive
nmap <leader>gs :Gstatus<cr>
" nmap <leader>gc :Gcommit<cr>
vmap <leader>ga :Gblame<cr>
" nmap <leader>ga :Gblame<cr>
nmap <leader>gl :Glog<cr>
nmap <leader>gd :Gdiff<cr>

" write on loss of focus.
" au FocusLost * :wa
" try no shift for a bit.
nnoremap ; :

" 7.3 stuff.
set number
set undofile
set undodir^=~/.vim/undo

hi DiffAdd      ctermfg=0 ctermbg=2 guibg='green'
hi DiffDelete   ctermfg=0 ctermbg=1 guibg='red'
hi DiffChange   ctermfg=0 ctermbg=3 guibg='yellow'

let g:syntastic_python_checkers = ['flake8']
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol='✗'
let g:syntastic_warning_symbol='⚠'
let g:syntastic_enable_balloons = 1
let g:syntastic_javascript_checkers = ['eslint', 'stylelint']

" stop :w lag w/ golang
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

let g:unite_enable_start_insert=1

" autocmd BufNewFile,BufRead */fdp*py set expandtab
" autocmd BufNewFile,BufRead */psa*py set expandtab

" autocmd BufReadPost * :DetectIndent

" let g:ftplugin_sql_omni_key = ''


let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'

let g:airline_powerline_fonts = 1
let g:airline#extensions#ale#enabled = 1
let g:ale_lint_on_text_changed = 0
let g:ale_fix_on_save = 0
let g:ale_linters = {'jsx': ['stylelint', 'eslint']}
let g:ale_linter_aliases = {'jsx': 'css'}
let g:ale_fixers = {
\   'javascript': [
\       'prettier',
\       'eslint',
\   ],
\}
map <f5> :ALELint<cr>
map <f6> :ALEFix<cr>


nmap <leader>j :%!python -m json.tool<cr>
vmap <leader>j :'<,'>!python -m json.tool<cr>

let NERDTreeIgnore=['\.pyc$']
" let g:tagman_ctags_binary = '/Users/simon/bin/gtags'
"
let g:jsx_ext_required = 0
autocmd FileType less setlocal omnifunc=csscomplete#CompleteCSS noci
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS noci


let g:prettier#autoformat = 0
" max line lengh that prettier will wrap on
let g:prettier#config#print_width = 100
" single quotes over double quotes
let g:prettier#config#single_quote = 'true'
" print spaces between brackets
let g:prettier#config#bracket_spacing = 'true'


nnoremap <silent> <Leader>ag :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>f :ALEFix<CR>


let g:gutentags_file_list_command = 'rg --files'

"
" Playing w/ the js imports
"
function! s:js_dep_sink(line)
  let parts = split(a:line)
  execute 'silent e' 'src/' . parts[1]
endfunction

function! s:treeme()
  echom "zing"
  call fzf#run({
  \ 'source':  './parse.js ' . expand('%'),
  \ 'sink':    function('s:js_dep_sink'),
  \ 'down': '20%'})
endfunction

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

command! TreeMe call s:treeme()
