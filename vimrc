""""""""""""""""""""""""""""
" Vundle
""""""""""""""""""""""""""""
source ~/.vim/bundles.vim 
"

"filetype plugin indent on
"

" Platform
function! MySys()
	if has("win32") || has("win64")
	return "windows"
elseif has("mac")
	return "mac"
else
	return "linux"
endif
endfunction

" Move Backup Files to ~/.vim/backups/
set backupdir=~/.vim/backups
set dir=~/.vim/backups
set nobackup
set undodir=~/.vim/undos
set undofile

set t_Co=256                                                      " Explicitly tell vim that the terminal has 256 colors "
set laststatus=2   " Always show the statusline
set ambiwidth=single
set clipboard=unnamed
set expandtab
" 行间距
set linespace=4
" 显示行号
set number
" 用 <> 调整缩进的长度
set shiftwidth=4
" tab 符的长度
set tabstop=4
set softtabstop=4

" 行号栏的宽度
set numberwidth=4
" 禁止自动换行
set nowrap
set wildmenu
set wildmode=longest:full,full
" set wildignore+=*.orig,*.pyc
" 分割窗口时 保持相等的宽/高
set equalalways
" 匹配括号的规则，增加了针对HTML的<>
set matchpairs=(:),{:},[:],<:>
" 退格、空格、上下箭头 遇到 行首 行尾 时 自动移动下一行(包括insert模式)
set whichwrap=b,s,<,>,[,]
set foldmethod=marker
set diffopt+=iwhite,vertical " 忽略缩进的差异

""""""""""""""""""""""""""""""""""""""""
" vim  UI
""""""""""""""""""""""""""""""""""""""""
"" color scheme
" http://fideloper.com/mac-vim-tmux
"
" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if has("gui_running") || has("gui_macvim")
	colorscheme obsidian2
	let g:colors_name="obsidian2"
else
"	colorscheme molokai
"
    let g:solarized_termcolors=256
    syntax enable
    set background=dark
    colorscheme solarized
"
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" filetype and syntax
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:javascript_enable_domhtmlcss=1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MacVim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("gui_macvim")	" 取消默认的快捷键
	let macvim_skip_cmd_opt_movement = 1
	let macvim_hig_shift_movement = 1
	" 设置背影透明度
	set transparency=9
	" 隐藏工具栏
	set guioptions-=T 

endif

" autocmd
autocmd! bufwritepost .vimrc source ~/.vimrc
autocmd! VimEnter *  :silent !~/.vim/phpctags -R *

" filetype
autocmd BufNewFile,BufRead jquery.*.js set ft=javascript syntax=jquery
autocmd BufNewFile,BufRead *.md setlocal ft=markdown
autocmd BufNewFile,BufRead *.scss set ft=scss

" Language support
autocmd FileType javascript setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 textwidth=80
autocmd FileType css setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" 设置 <leader> 快捷键
let mapleader=","
let g:mapleader=","

map <silent> <leader>rc :tabe ~/.vimrc<cr>
map <leader>q :q<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugin setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NREDTree setting
let g:NERDTreeWinSize = 20
nmap <silent> <leader>nt :call OpenNERDTree()<cr>

function! OpenNERDTree()
	" let tmp = g:eighties_minimum_width
	let g:eighties_minimum_width = 20
	:NERDTree
	" let g:eighties_minimum_width = tmp
endfunction

" eighties
let g:eighties_enabled = 1
let g:eidthies_minimum_width = 80
let g:eighties_extra_width = 0
let g:eighties_compute = 1
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let NERDTreeWinSize=30
let NERDTreeChDirMode=2
let NERDChristmasTree=0
" Syntastic


let g:syntastic_javascript_checkers = ['jshint']
let g:loaded_html_syntax_checked = 1
let g:syntastic_auto_loc_list=0

" tasklist
nmap <silent> <leader>tl <Plug>TaskList

" tagbar
let g:tagbar_width = 20
let g:tagbar_singleclick = 1
let g:tagbar_iconchars = ['▾', '▸']
let g:tagbar_ctags_bin='/usr/local/bin/ctags'
nnoremap <leader>tb :TagbarToggle<CR>

" session
let g:session_autoload = 'no'
nnoremap <leader>ss :SaveSession
nnoremap <leader>so :OpenSession
nnoremap <leader>sd :DeleteSession
nnoremap <leader>sc :CloseSession<cr>
nnoremap <leader>sv :ViewSession<cr>

" ctrl-p MRU + ctrlp
let g:ctrlp_working_path_mode=2 " .git/ .hg/ .svn/ .bzr/ _darcs/ or your own marker_dir/ marker_file
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = ':CtrlPMRU'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
let g:ctrlp_user_command = 'find %s -type f'  

let g:Powerline_symbols = 'compatible'

" UltiSnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"


" neocomplcache
" Use neocomplcache
let g:neocomplcache_enable_at_startup = 1
" Use smartcase
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length
let g:neocomplcache_min_syntax_length = 1
let g:neocomplcache_auto_completion_start_length = 1
let g:neocomplcache_manual_completion_start_length = 1
let g:neocomplcache_max_list = 20

" html5
let g:html5_complete = 0
let g:html5_rdfa_attributes_complete = 0
let g:html5_microdata_attributes_complete = 0
let g:html5_aria_attributes_complete = 0
let g:aria_attributes_complete = 0


" " easymotion 
" let g:EasyMotion_smartcase = 1
" let g:EasyMotion_leader_key = ','
" let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
" map <Leader><leader>h <Plug>(easymotion-linebackward)
" " map <Leader><Leader>j <Plug>(easymotion-j)
" " map <Leader><Leader>k <Plug>(easymotion-k)
" map <Leader><leader>l <Plug>(easymotion-liGneforward)
"  重复上一次操作, 类似repeat插件, 很强大
" map <Leader><leader>. <Plug>(easymotion-repeat)




"xnoremap p pgvy

"  phpctags 
"let g:tagbar_phpctags_bin='~/.vim/phpctags'
 "

" neosnippet Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-k>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

" Yank text to the OS X clipboard" 将文本复制到OS X剪贴板中
noremap <leader>p :set paste<CR>:put *<CR>:set nopaste<CR>
" noremap <leader>y "*y
" noremap <leader>yy "*Y

" -----------------  neocomplcache start here 0

"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : '',
    \ 'vimshell' : $HOME.'/.vimshell_hist',
    \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

if filereadable(glob("~/.vimrc.local")) 
    source ~/.vimrc.local
endif
