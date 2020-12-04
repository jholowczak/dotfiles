"""""""""""""""""""""""""""""
"        Behaviour          "
"""""""""""""""""""""""""""""
set nocompatible    " Don't behave like Vi
set shell=/usr/bin/bash " set shell to bash so bash bindings work (I use fish)
set wildmenu        " Enhanced command line completion
set wildmode=longest,list   " Complete the longest match, then list others
set backspace=indent,eol,start  " Allow backspacing over more stuff
set confirm         " Ask to confirm instead of failing
set ignorecase      " Case insensitive search
set smartcase       " Case sensitive if search term contains capitals
set linebreak       " Allow linebreaks between words
set scrolloff=2     " Start scrolling a few lines from the border
set visualbell      " Use colour blink instead of sound
set display+=lastline   " Always display the last line of the screen
set encoding=utf8   " Use utf8 as internal encoding
set whichwrap+=<,>,h,l  " Allow cursor to wrap lines
set hidden          " Allow opening new buffers without saving changes
set laststatus=2    " Wider status line, needed for powerline
set mouse=a

"""""""""""""""""""""""""""""
"        Formatting         "
"""""""""""""""""""""""""""""
set tabstop=4       " Width of the tab character
set softtabstop=4   " How many columns the tab key inserts
set shiftwidth=4    " Width of 1 indentation level
set expandtab       " Expand tabs into spaces
set smartindent     " Smart C-like autoindenting
set exrc                        " Read ./.vimrc
set fileformats=unix,dos,mac    " Choose line ending sanely
set showmatch                 	" Highlight matching brackets
set splitbelow                	" Put new splits down
set splitright                 	" Put new vsplits right

filetype off

"""""""""""""""""""""""""""""
"        Interface          "
"""""""""""""""""""""""""""""
set number          " Show line numbers
set showmatch       " When inserting brackets, highlight the matching one
set hlsearch        " Highlight search results
set incsearch       " Highlight search results as the search is typed
set showcmd         " Show command on the bottom
set ruler           " Show line and cursor position
set colorcolumn=80  " Highlight the 80th column
set listchars=tab:>-,trail:· " Show tabs and trailing space
set list            " Enable the above settings
syntax on           " Enable syntax highlighting

"""""""""""""""""""""""""""""
"        Reload Hook        "
"""""""""""""""""""""""""""""
augroup myvimrchooks
    au!
    autocmd bufwritepost .vimrc source ~/.vimrc
augroup END

"""""""""""""""""""""""""""""
"  Self-defined Functions   "
"""""""""""""""""""""""""""""
function! AutoHighlightToggle()
   let @/ = ''
   if exists('#auto_highlight')
     au! auto_highlight
     augroup! auto_highlight
     setl updatetime=4000
     set nohls
     return 0
  else
    set hls
    augroup auto_highlight
    au!
    au CursorHold * let @/ = '\V\<'.escape(expand('<cword>'), '\').'\>'
    augroup end
    setl updatetime=25
  return 1
 endif
endfunction

function! NearestMethodOrFunction() abort
  return get(b:, 'vista_nearest_method_or_function', '')
endfunction

"""""""""""""""""""""""""""""
"        Plugins            "
"""""""""""""""""""""""""""""
call plug#begin('~/.config/nvim/plugged')
Plug 'derekwyatt/vim-fswitch'
Plug 'severin-lemaignan/vim-minimap'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'mdempsky/gocode', { 'rtp': 'vim/', 'for': 'go', 'do': 'go get -u github.com/nsf/gocode' }
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'liuchengxu/vista.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'gikmx/ctrlp-obsession'
Plug 'Raimondi/delimitMate'
Plug 'mattn/emmet-vim'
"Plug 'majutsushi/tagbar'
Plug 'Yggdroot/indentLine'
Plug 'gregsexton/MatchTag'
Plug 'nanotech/jellybeans.vim'
Plug 'AndrewRadev/switch.vim'
Plug 'vim-syntastic/syntastic'
Plug 'vim-scripts/taglist.vim'
Plug 'easymotion/vim-easymotion'
Plug 'mtth/scratch.vim'
Plug 'junegunn/vim-easy-align'
Plug 'airblade/vim-gitgutter'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
"Plug 'racer-rust/vim-racer', { 'for': 'rs' }
Plug 'rust-lang/rust.vim', { 'for': 'rs'}
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-surround'
Plug 'Shougo/vinarise.vim'
Plug 'ervandew/supertab'
Plug 'christoomey/vim-tmux-navigator'
Plug 'benmills/vimux'
Plug 'benmills/vimux-golang', { 'for': 'go' }
Plug 'w0rp/ale'
Plug 'lervag/vimtex', { 'for': 'tex' }
Plug 'jceb/vim-orgmode', { 'for': 'org' }
Plug 'pangloss/vim-javascript', { 'for': 'js' }
Plug 'mxw/vim-jsx', { 'for': 'js' }
Plug 'plasticboy/vim-markdown', { 'for': 'md'}
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'rhysd/vim-clang-format'
"Plug 'Valloric/YouCompleteMe'
Plug 'suan/vim-instant-markdown', {'rtp': 'after', 'for': 'md' }
call plug#end()

filetype plugin indent on

"""""""""""""""""""""""""""""
"        Key mapping        "
"""""""""""""""""""""""""""""
let mapleader = " "
nnoremap <leader>ss :setlocal spell spelllang=en_us<cr>
nnoremap <leader>sf :setlocal nospell<cr>
" j and k go up/down a row in wrapped lines
nnoremap <expr> j v:count ? (v:count > 5 ? "m'" . v:count : '') . 'j' : 'gj'
nnoremap <expr> k v:count ? (v:count > 5 ? "m'" . v:count : '') . 'k' : 'gk'

nnoremap <leader>, <Ctrl-B>
nnoremap <leader>. <Ctrl-F>
" Use space to clear search highlights and any message displayed
nnoremap <silent> <Space> :silent noh<Bar>echo<CR>
nmap <leader>hw    :call AutoHighlightToggle()<CR>
nmap <leader>hh    :noh<CR>

"tab changes on the fly
nnoremap <Leader>te :set expandtab<CR>
nnoremap <Leader>tn :set noexpandtab<CR>

" Tabs navigation
nnoremap bh  :tabfirst<CR>
nnoremap bj  :tabnext<CR>
nnoremap bk  :tabprev<CR>
nnoremap bl  :tablast<CR>
nnoremap bt  :tabedit<Space>
nnoremap bn  :tabnew<CR>
nnoremap bm  :tabm<Space>
nnoremap bd  :tabclose<CR>

" Buffer control
nnoremap <silent> <leader>nn :bn<CR>
nnoremap <silent> <leader>np :bp<CR>
nnoremap <silent> <leader>nm :bp<CR>
nnoremap <silent> <leader>nd :bd<CR>
nnoremap <silent> <leader>no :only<cr>
nnoremap <silent> <leader>ns <C-W><C-W>
nnoremap <silent> <leader>= <C-w>=
nnoremap <silent> <leader>z <C-w>z

" split control
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <silent> vv <C-w>v
nnoremap <silent> <leader>aw :vsp<CR>
nnoremap <silent> <leader>aq :sp<CR>
nnoremap <silent> <leader>aa <C-W>_
nnoremap <silent> <leader>as <C-W>|
nnoremap <silent> <leader>aa <C-W>=
nnoremap <silent> <leader>ar <C-W>R
nnoremap <silent> <leader>at <C-W>T
nnoremap <silent> <leader>ao <C-W>o


" taken from kyle's dotfiles on github, made some changes
autocmd FileType c,cpp,ocaml nnoremap <buffer><leader>rr :!make run<cr>
autocmd FileType c,cpp,ocaml nnoremap <buffer><leader>rt :!make test<cr>
autocmd FileType c,cpp,ocaml nnoremap <buffer><leader>rb :!make<cr>
autocmd FileType c,cpp,javascript nnoremap <buffer><leader>rf :!ClangFormat<cr>
autocmd FileType haskell nnoremap <buffer><leader>rr :!stack run<cr>
autocmd FileType haskell nnoremap <buffer><leader>rt :!stack test<cr>
autocmd FileType haskell nnoremap <buffer><leader>rb :!stack build<cr>
autocmd FileType haskell nnoremap <buffer><leader>re :!stack %<cr>
autocmd FileType haskell nnoremap <buffer><leader>t :!GhcModType<cr>
autocmd FileType python nnoremap <buffer><leader>rr :!python %<cr>
autocmd FileType python nnoremap <buffer><leader>rt :!python -m pytest -s %<cr>
autocmd FileType python nnoremap <buffer><leader>rl :!pylint %<cr>
autocmd FileType python nnoremap <buffer><leader>rb :!/usr/bin/black %<cr>
autocmd FileType rust nnoremap <buffer><leader>rr :!cargo run<cr>
autocmd FileType rust nnoremap <buffer><leader>rt :!cargo test<cr>
autocmd FileType rust nnoremap <buffer><leader>rb :!cargo build<cr>
autocmd FileType rust let g:rustfmt_autosave = 1

autocmd FileType go nnoremap <buffer><leader>rb :!go build<cr>
"autocmd FileType go nnoremap <buffer><leader>rt :!go test<cr>
"autocmd FileType go nnoremap <buffer><leader>rf :!cd %:p:h && go test && cd -<cr>
autocmd FileType go nnoremap <buffer><leader>t :GoInfo<cr>
" vimux-golang
autocmd FileType go nnoremap <buffer><leader>rt :wa<CR> :GolangTestCurrentPackage<CR>
autocmd FileType go nnoremap <buffer><leader>rf :wa<CR> :GolangTestFocused<CR>

" F3 toggles paste mode
set pastetoggle=<F3>

"""""""""""""""""""""""""""""
"        Colours and GUI    "
"""""""""""""""""""""""""""""
if &term=='xterm'   " xterm supports 256 colours but doesn't set this
    set t_Co=256
    colorscheme gruvbox  " Use nicer colourscheme
    hi Normal ctermbg=none
endif
if &t_Co==256
    set background=dark     " Use dark background
    colorscheme gruvbox  " Use nicer colourscheme
    hi Normal ctermbg=none
endif
" Highlight all instances of word under cursor, when idle.
" Useful when studying strange source code.


"""""""""""""""""""""""""""""
"        Plugin Settings    "
"""""""""""""""""""""""""""""
" Syntastic
let g:syntastic_mode_map = { 'mode': 'passive' }
nmap <silent> <leader>st    :SyntasticToggleMode<CR><CR>
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%{NearestMethodOrFunction()}
set statusline+=%*

autocmd VimEnter * call vista#RunForNearestMethodOrFunction()

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" YCM and Language Bindings
" python
let g:ycm_server_python_interpreter = "/usr/bin/python"
let g:ycm_python_binary_path = 'python'

" ycm
"let g:ycm_global_ycm_extra_conf = expand("~/.vim/.ycm_extra_conf.py")

" vinarise
let g:vinarise_enable_auto_detect = 1
nmap <leader>vv    :Vinarise<CR>

" vim-numbertoggle
nmap <silent> <leader>sr     :set number relativenumber<CR>
nmap <silent> <leader>sn     :set number norelativenumber<CR>

" Switch.vim
let g:switch_mapping = "-"

" Fugitive
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gs :Gstatus<CR>
" - add/reset a files changes
" p add/reset --patch
nnoremap <leader>gC :Gcommit<CR>
nnoremap <leader>gc :Gcommit %<CR>
nnoremap <leader>gb :Gblame<CR>
nnoremap <leader>gp :Gpull<CR>
nnoremap <leader>gP :Gpush<CR>

" Easyalign
nnoremap <leader>ea :EasyAlign<CR> 

"ALE
nnoremap <silent> <leader>ale :ALEToggle<CR> 
"let g:ale_completion_enabled=1
"let g:ale_linters = {'rust': ['analyzer']}

" indentLine
let g:indentLine_char = '▏'
let g:indentLine_color_term = 241
let g:indentLine_enabled = 1

" airline
" nnoremap <leader>ss :AirlineTheme <TAB>

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Airline
let g:airline#extensions#tabline#enabled = 1    " Enable nice tabline
let g:airline#extensions#tabline#show_buffers=1
let g:airline_powerline_fonts = 1
let g:airline_theme = 'hybrid'
"let g:airline#extensions#coc#enabled = 1

" NERDTree
nnoremap <silent> <F2> :NERDTreeToggle<CR>
nnoremap <silent> <leader>f :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$', '^__pycache__$', '^node_modules', '\.png$', '\.jpg', '\.bmp']
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeDirArrows = 0   " Disable fancy arrows in NERDTree

" delimitMate
let delimitMate_expand_cr = 1

"supertab
let g:SuperTabDefaultCompletionType = "<C-X><C-O>"

" UltiSnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" TagBar
let g:tagbar_left = 1
let g:airline#extensions#tagbar#enabled = 0
nmap <F8> :TagbarToggle<CR>
nnoremap <silent> <leader>x :TagbarToggle<CR>
let g:tagbar_type_go = {
    \ 'ctagstype': 'go',
    \ 'kinds' : [
        \'p:package',
        \'f:function',
        \'v:variables',
        \'t:type',
        \'c:const'
    \]
    \}
let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type'
    \ },
    \ 'scope2kind' : {
        \ 'module' : 'm',
        \ 'class'  : 'c',
        \ 'data'   : 'd',
        \ 'type'   : 't'
    \ }
    \ }
let g:tagbar_type_make = {
            \ 'kinds':[
                \ 'm:macros',
                \ 't:targets'
            \ ]
            \}
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3'
    \ ]
    \ }

" open header fswitch
nmap <silent> <F4> :FSHere<cr>
nmap <silent> <Leader>of :FSHere<cr>
nmap <silent> <Leader>ol :FSRight<cr>
nmap <silent> <Leader>oL :FSSplitRight<cr>
nmap <silent> <Leader>oh :FSLeft<cr>
nmap <silent> <Leader>oH :FSSplitLeft<cr>
nmap <silent> <Leader>ok :FSAbove<cr>
nmap <silent> <Leader>oK :FSSplitAbove<cr>
nmap <silent> <Leader>oj :FSBelow<cr>
nmap <silent> <Leader>oJ :FSSplitBelow<cr>

" CtrlProsession
nnoremap <Leader>ss :CtrlPObsession<CR>

" Minimap
nmap <silent> <F9> :MinimapToggle<cr>

"easymotion
map <Leader> <Plug>(easymotion-prefix)

" vim-markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_folding_disabled = 1

" vim-instant-markdown
nmap <silent> <Leader>mp :InstantMarkdownPreview<cr>
nmap <silent> <Leader>ms :InstantMarkdownStop<cr>
let g:instant_markdown_slow = 0
let g:instant_markdown_autostart = 0
let g:instant_markdown_open_to_the_world = 0
"let g:instant_markdown_allow_unsafe_content = 1
"let g:instant_markdown_allow_external_content = 0
"let g:instant_markdown_mathjax = 1
"let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
"let g:instant_markdown_autoscroll = 0
let g:instant_markdown_port = 8888
let g:instant_markdown_python = 1

" vimux
nmap <leader>vp :VimuxPromptCommand<CR>
nmap <leader>vl :VimuxRunLastCommand<CR>

"vim-scratch
nmap gn :Scratch<CR>
