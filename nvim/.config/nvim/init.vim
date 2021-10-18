"""""""""""""""""""""""""""""
"        Behaviour          "
"""""""""""""""""""""""""""""

set nocompatible    " Don't behave like Vi
if has('macunix')
    set shell=/usr/local/bin/bash
else
    set shell=/usr/bin/bash " set shell to bash so bash bindings work (I use fish)
endif
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
    autocmd bufwritepost init.vim source ~/.config/nvim/init.vim
augroup END

" auto-install vim-plug
"let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
"if empty(glob(data_dir . '/autoload/plug.vim'))
"  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
"endif

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
" ---
" FILE-BASED PLUGINS
" ---
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'derekwyatt/vim-fswitch'
Plug 'severin-lemaignan/vim-minimap'
Plug 'tpope/vim-fugitive'
Plug 'jreybert/vimagit'

" ---
" FUZZY
" ---
" ctrlp is needed for other plugins, must be loaded first
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" ---
" MOVEMENT PLUGINS
" ---
Plug 'benmills/vimux'
Plug 'benmills/vimux-golang', { 'for': 'go' }
Plug 'easymotion/vim-easymotion'
Plug 'christoomey/vim-tmux-navigator'

" ---
" SNIPPETS
" ---
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" ---
" LSP
" ---
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'
Plug 'liuchengxu/vista.vim'
Plug 'dense-analysis/ale'

" ---
" VIM THEMING
" ---
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'flazz/vim-colorschemes'

" ---
" SESSION MANAGEMENT
" ---
Plug 'tpope/vim-obsession'
Plug 'dhruvasagar/vim-prosession'
Plug 'gikmx/ctrlp-obsession'

" ---
" HELPERS
" ---
" auto(smartish) closing of quotes, parens, etc
Plug 'Raimondi/delimitMate' 
" Add indent alignment lines to view
Plug 'Yggdroot/indentLine'
" swap common values (booleans, arrows, etc) easily
Plug 'AndrewRadev/switch.vim'
" git diff symbols in gutter
Plug 'airblade/vim-gitgutter'
" swap between relative and absolute line numbering
Plug 'jeffkreeftmeijer/vim-numbertoggle'
" alignment plugin
Plug 'junegunn/vim-easy-align'
" add/delete/change (parens, brackets, quotes, etc)
Plug 'tpope/vim-surround'
" unobtrusive scratch window
Plug 'mtth/scratch.vim'
" hex editor in vim
Plug 'Shougo/vinarise.vim'

" ---
" LANGUAGES
" ---
" syntax checking
Plug 'vim-syntastic/syntastic'

" C
" format C family code
Plug 'rhysd/vim-clang-format', {'for': 'c,h,cpp,hpp'}

" GO
Plug 'fatih/vim-go', { 'for': 'go' }

" HTML
" expand html abbreviations similar to emmet
Plug 'mattn/emmet-vim', {'for': 'html'}
" highlight matching HTML tags
Plug 'gregsexton/MatchTag', { 'for': 'html,js'}

" JAVASCRIPT/JSON
Plug 'pangloss/vim-javascript', { 'for': 'js' }
Plug 'mxw/vim-jsx', { 'for': 'js' }
Plug 'elzr/vim-json', { 'for': 'json' }

" LATEX
Plug 'lervag/vimtex', { 'for': 'tex' }

" MARKDOWN
Plug 'plasticboy/vim-markdown', { 'for': 'md'}
Plug 'suan/vim-instant-markdown', {'rtp': 'after', 'for': 'md' }

" ORG
Plug 'jceb/vim-orgmode', { 'for': 'org' }

" RUST
Plug 'rust-lang/rust.vim', { 'for': 'rs'}

" R
Plug 'jalvesaq/Nvim-R', {'for': 'R', 'branch': 'stable'}


" ---
" RETIRED PLUGINS
" ---
"Plug 'justinmk/vim-sneak'
"Plug 'vim-scripts/taglist.vim'
"Plug 'nanotech/jellybeans.vim'
"Plug 'mdempsky/gocode', { 'rtp': 'vim/', 'for': 'go', 'do': 'go get -u github.com/nsf/gocode' }
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
"Plug 'majutsushi/tagbar'
"Plug 'Valloric/YouCompleteMe'
"Plug 'ervandew/supertab'
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

" config editor
nnoremap <silent> <leader>co :edit ~/.config/nvim/init.vim<CR>
nnoremap <silent> <leader>cl :source ~/.config/nvim/init.vim<CR>

"Scratch binds
nnoremap <silent> <leader>; :Scratch<CR>


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
if has('macunix')
    autocmd FileType python nnoremap <buffer><leader>rr :!python3 %<cr>
    autocmd FileType python nnoremap <buffer><leader>rt :!python3 -m pytest -s %<cr>
else
    autocmd FileType python nnoremap <buffer><leader>rr :!python %<cr>
    autocmd FileType python nnoremap <buffer><leader>rt :!python -m pytest -s %<cr>
endif
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

autocmd FileType sh nnoremap <buffer><leader>rr :!./%<CR>

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
"let g:ycm_server_python_interpreter = "/usr/bin/python"
"let g:ycm_python_binary_path = 'python'

" ycm
"let g:ycm_global_ycm_extra_conf = expand("~/.vim/.ycm_extra_conf.py")

" vinarise
let g:vinarise_enable_auto_detect = 1
nmap <leader>vv    :Vinarise<CR>

" vim-numbertoggle
nmap <silent> <leader>sr     :set number relativenumber<CR>
nmap <silent> <leader>sn     :set number norelativenumber<CR>

" vim-magit
nmap <silent> <leader>ms :Magit<CR>

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
let g:ale_linters_explicit = 1 
let g:ale_completion_enabled = 1
let g:ale_list_window_size = 1
let g:ale_close_preview_on_insert = 1
set omnifunc=ale#completion#OmniFunc
let g:ale_fixers = {
    \ 'rust': ['rustfmt']
    \ }
let g:ale_linters = {
    \ 'rust': ['rust-analyzer']
    \ }
let g:ale_completion_enabled=1
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
nnoremap <silent> <leader>nt :NERDTreeToggle<CR>
autocmd VimEnter * call NERDTreeAddKeyMap({
    \ 'key': '<tab>',
    \ 'callback': 'NERDTreeCustomOpenerTab',
    \ 'quickhelpText': 'open node' })
function! NERDTreeCustomOpenerTab()
    let n = g:NERDTreeFileNode.GetSelected()
    if n != {}
        if !n.path.isDirectory
            call n.open()
            NERDTreeClose
        else
            " if the node is a dir then just activate it as norm
            call n.activate()
        endif
    endif
endfunction
let NERDTreeIgnore = ['\.pyc$', '^__pycache__$', '^node_modules', '\.png$', '\.jpg', '\.bmp']
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeDirArrows=0   " Disable fancy arrows in NERDTree
let NERDTreeShowHidden=1

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
nmap <silent> <Leader>mP :InstantMarkdownStop<cr>
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

" LSP config (the mappings used in the default file don't quite work right)
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> <C-n> <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent> <C-p> <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

" auto-format
autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.jsx lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.py lua vim.lsp.buf.formatting_sync(nil, 100)
autocmd BufWritePre *.rs lua vim.lsp.buf.formatting_sync(nil, 100)

lua << EOF
vim.o.completeopt = "menuone,noselect"

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = false;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = true;
  };
}
local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
EOF

lua << EOF
require'lspconfig'.rust_analyzer.setup{}
EOF

"
" R 
"
augroup ft_r

let R_assign = 0
let R_in_buffer = 1
let R_applescript = 0
let r_indent_comment_column = 0

function SendRFunc () 
    let lines = []
    let leftbracket = 0

    " find first opening bracket
    while line('.') <= line('$') 
        let cur = getline(".")
        execute "normal! j"
        let lines = add(lines, cur)

        if cur =~ '{$'
            break
        endif
    endwhile

    let leftbracket += 1

    while leftbracket > 0 && line('.') <= line('$')
        let cur = getline(".")
        execute "normal! j"
        let lines = add(lines, cur)

        if cur =~ '}$'
            let leftbracket -= 1
        endif

        if cur =~ '{$'
            let leftbracket += 1
        endif

    endwhile

    for line in lines
        VimuxRunCommand(line)
    endfor

endfunction

function SendRRegion() 
    let lines = []

    while line('.') <= line('$')
        let cur = getline(".")
        execute "normal! j"
        let lines = add(lines, cur)

        if cur =~ '^$'
            break
        endif

    endwhile

    for line in lines
        VimuxRunCommand(line)
    endfor

endfunction

function SendToR ()
    let lines = []

    if getline('.') =~ 'function' || getline('.') =~ 'for'
        call SendRFunc() 
    else
        call SendRRegion()
    endif
endfunction

autocmd FileType r,rmd nnoremap <buffer><leader>rr :call SendToR()<cr>
augroup END


