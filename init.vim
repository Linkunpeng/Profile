"
"                           lkp's VIM
"
"                   Geting Start ------>  (>^.^< ) !!!
"
"----------------------------------------------------------------------
"                                                                     |
"                                                             |\      |
"                                                             |_\     |
"                                                             |       |
"              ============        ==========                 |       |
"                  |-|                                        |       |
"   0              |-|                                        |       |
"  /1\             |-|                                     -------    |
"   ハ             |-|                                    /--------\  |
"----------------------------------------------------------------------

" Setting {{{

set nocompatible
set number
set relativenumber
set magic
set ruler
set hidden
set ignorecase
set smartcase
set incsearch
set termguicolors
set foldmethod=manual
set nobackup
set nowritebackup
set cmdheight=2
set cursorline
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoread
set encoding=utf-8
set path+=**/**
set suffixesadd+=.h
set tags=tags;
set wrap
set textwidth=80
syntax enable
syntax on
filetype off
set grepprg=ag\ --vimgrep\ $*
set grepformat=%f:%l:%c:%m

let mapleader = ","
let maplocalleader = ","

"}}}
" Background{{{

" let g:molokai_original = 1
set background=dark
colorscheme molokai
" colorscheme gruvbox

" highlight Normal guibg=NONE ctermbg=NONE

"}}}
"KeyMap{{{

nnoremap H <kHOME>
nnoremap L <kEND>
nnoremap <M-f> <C-Right>
nnoremap <M-b> <C-Left>
nnoremap j gj
nnoremap k gk
nnoremap <leader>p "+p
nnoremap <C-l> :nohl<CR><C-l>
nnoremap <leader>= ggVG=
nnoremap & :&&<CR>
nnoremap <C-w>J :resize +10<CR>
nnoremap <C-w>K :resize -10<CR>
nnoremap <C-w>H :vertical resize -10<CR>
nnoremap <C-w>L :vertical resize +10<CR>
" nnoremap <leader>ta :<C-u>!ctags --exclude=.git -R .<CR> :<C-u>UpdateTypesFile<CR>

inoremap <C-a> <kHOME>
inoremap <C-e> <kEND>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <M-f> <C-Right>
inoremap <M-b> <C-Left>
inoremap <C-d> <del>
inoremap jk <ESC>

cnoremap <C-a> <kHOME>
cnoremap <C-e> <kEND>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
cnoremap <M-f> <C-Right>
cnoremap <M-b> <C-Left>
cnoremap jk <ESC>

vnoremap H <kHOME>
vnoremap L <kEND>

xnoremap & :&&<CR>
xnoremap * :<C-u>call <SID>VSetSearch()<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch()<CR>?<C-R>=@/<CR><CR>
xnoremap <leader>y "+y



"}}}
" Autocmd{{{

augroup lkp_group
  autocmd!
  autocmd FileType make set noexpandtab
  " autocmd BufWritepost *.[ch] silent execute ":!ctags --exclude=.git -R ."
augroup END

"}}}
" Function {{{

function! s:VSetSearch()
let temp = @s
norm! gv"sy
let @/ = '\V' . substitute(escape(@s, '/\'), '\n', '\\n', 'g')
let @s = temp
endfunction

" }}}

"----------------------------------------------------------------------
"---------------------------- Plug Setting ----------------------------
"----------------------------------------------------------------------
"                                 ||                                  -
"                                 ||                                  -
"                                 ||                                  -
"                               \\||//                                -
"                                \\//                                 -
"                                 \/                                  -

" COC{{{
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
" nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
" xmap <leader>a  <Plug>(coc-codeaction-selected)
" nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
" nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
" nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
" nmap <silent> <C-d> <Plug>(coc-range-select)
" xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" " Show all diagnostics
" nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions
" nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" " Show commands
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document
" nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list
" nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"}}}
"Ultisnips{{{
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<M-f>"
let g:UltiSnipsJumpBackwardTrigger="<M-b>"
let g:UltiSnipsEditSplit="vertical"
let g:UltiSnipsNoPythonWarning = 1
"}}}
"NERDCOMMENTER{{{
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1
"}}}
" EasyMotion{{{
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
" nmap <leader>j <Plug>(easymotion-overwin-f)
" nmap <leader>j <Plug>(easymotion-overwin-f2)
map  <Leader>e <Plug>(easymotion-bd-w)
nmap <Leader>e <Plug>(easymotion-overwin-w)
" }}}

" C++Enhanced Highlight{{{

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
let g:cpp_no_function_highlight = 1


" }}}
" TagHighlight{{{

" let g:PythonVariantPriority=["if_pyth","if_pyth3","python","compiled"]
let g:TagHighlightSettings = {'PythonVariantPriority':'if_pyth'}

"}}}
"rainbow{{{

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
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

    " \ ['black',       'SeaGreen3'],
let g:rbpt_max = 16

let g:rbpt_loadcmd_toggle = 0

augroup rainbow_lkp
  autocmd!
  au VimEnter * RainbowParenthesesToggle
  au Syntax * RainbowParenthesesLoadRound
  au Syntax * RainbowParenthesesLoadSquare
  au Syntax * RainbowParenthesesLoadBraces
augroup END
"}}}

" NERDTREE: {{{

let NERDTreeWinSize=25
let NERDTreeShowHidden=1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
nnoremap dir :NERDTreeToggle<CR>
"}}}
"Tagbar{{{

let g:tagbar_left = 0
let g:tagbar_width = 30
nnoremap dit :TagbarToggle<CR>

"}}}
" Ack {{{
if executable('ag')
    let g:ackprg = 'ag --vimgrep $*'
endif
let g:ack_mappings = { "o": "<CR><C-W>j"}
let g:ackhighlight = 1

cabbrev ag Ack!
cabbrev aga AckAdd!
cabbrev agf AckFile!
cabbrev ack Ack!
cabbrev acka AckAdd!
cabbrev ackf AckFile!

"}}}
" Leaderf{{{

" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

" noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
" noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" search visually selected text literally
" xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
" noremap go :<C-U>Leaderf! rg --recall<CR>

" should use `Leaderf gtags --update` first
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_Gtagslabel = 'native-pygments'
" noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
" noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
" noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
" noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
" noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

" }}}



"VimWiki{{{
let wiki_1 = {}
let wiki_1.path = '~/tmp/.todo/'
let wiki_1.syntax = 'markdown'
let wiki_1.ext = '.md'

let g:vimwiki_global_ext = 0
let g:vimwiki_list = [wiki_1]
"}}}
"Translater{{{
let g:vtm_target_lang = 'zh'
let g:vtm_default_engines = ['google', 'bing']
" let g:vtm_default_engines = [ 'bing' ]
let g:vtm_proxy_url = ''
let g:vtm_history_enable = 1
let g:vtm_history_count = 5000
let g:vtm_history_dir = '/home/lkp/.vimtrans'
nmap <silent> <Leader>tt <Plug>Translate
vmap <silent> <Leader>tt <Plug>TranslateV
nmap <silent> <Leader>tw <Plug>TranslateW
vmap <silent> <Leader>tw <Plug>TranslateWV
nmap <silent> <Leader>tr <Plug>TranslateR
vmap <silent> <Leader>tr <Plug>TranslateRV
hi def link vtmQuery             Identifier
hi def link vtmParaphrase        Statement
hi def link vtmPhonetic          Special
hi def link vtmExplain           Comment
hi def link vtmPopupNormal       NormalFloat

" vnoremap <silent> <leader>tv :TranslateVisual<CR>
" let g:translate#default_languages = {
"       \ 'zh': 'en',
"       \ 'en': 'zh'
"       \ }
"}}}
" vimtex{{{
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-xelatex',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}
"}}}
" instant_markdown{{{
let g:instant_markdown_slow = 1
let g:instant_markdown_autostart = 0
" let g:instant_markdown_open_to_the_world = 1
" let g:instant_markdown_allow_unsafe_content = 1
" let g:instant_markdown_allow_external_content = 0
" let g:instant_markdown_mathjax = 1
" let g:instant_markdown_logfile = '/tmp/instant_markdown.log'
let g:instant_markdown_autoscroll = 1
" let g:instant_markdown_port = 8888
" let g:instant_markdown_python = 1
let g:instant_markdown_browser = "firefox --new-window"
"}}}
"gutentags{{{
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']
let g:gutentags_ctags_tagfile = '.tags'
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
   endif

let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" }}}





call plug#begin('~/.config/nvim/plugged')

"Code Edit
Plug 'neoclide/coc.nvim', {'branch': 'release'} " coc.nvim
Plug 'SirVer/ultisnips'                         " ultisnips
Plug 'honza/vim-snippets'                       " snippets
Plug 'scrooloose/nerdcommenter'                 " nerdcommenter
Plug 'bronson/vim-trailing-whitespace'          " fix whitespace
Plug 'easymotion/vim-easymotion'                " easymotion

" Code Read
Plug 'tomasr/molokai'                           " molokai
Plug 'morhetz/gruvbox'                          " gruvbox
Plug 'vim-airline/vim-airline'                  " airline
Plug 'vim-airline/vim-airline-themes'           " airline-themes
Plug 'magic-dot-files/TagHighlight'             " TagHighlight
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'kien/rainbow_parentheses.vim'             " rainbow()

Plug 'scrooloose/nerdtree'                      " nerdtree
Plug 'majutsushi/tagbar'                        " tagbar
Plug 'Yggdroot/LeaderF'                         " LeaderF
Plug 'mileszs/ack.vim'                          " ack

" Tools
Plug 'vimwiki/vimwiki'                          "vimwiki
Plug 'tpope/vim-fugitive'                       " fugit
Plug 'lervag/vimtex'                            " vimtex
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}  " markdown
Plug 'voldikss/vim-translate-me'                " translate
Plug 'ludovicchabant/vim-gutentags'             " Auto-ctags

call plug#end()

filetype plugin indent on
" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:


