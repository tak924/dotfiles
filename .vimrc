" .vimrc
" My Vim Configuration
" Date:     2015-05-24
" Comment:  First Configuration File
" Revdate:  
" Comment:  




"####################
"  基本設定
"####################
"{{{

"初期化設定
"{{{ 01
set nocompatible        "互換性OFF
set encoding=utf-8      "エンコーディング設定
scriptencoding utf-8    "Vim scriptファイルの文字コードを指定
"}}} /01

"画面表示設定
"{{{ 02
syntax on
set t_Co=256	"iTerm2 の Preferences > Profiles > Terminal の Report Terminal Type を xterm-256color に
set number              " 行番号を表示する
set cursorline          " カーソル行の背景色を変える
"set cursorcolumn        " カーソル位置のカラムの背景色を変える
set laststatus=2        " ステータス行を常に表示
set cmdheight=2         " メッセージ表示欄を2行確保
set showmatch           " 対応する括弧を強調表示
set list                " タブ・eolを表示
set listchars=tab:▸\ ,eol:¬
set foldmethod=marker   "畳み込みの有効化
""全角スペースの表示
function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=reverse ctermfg=DarkGray gui=reverse guifg=DarkGray
endfunction
if has('syntax')
    augroup ZenkakuSpace
        autocmd!
        "ZenkakuSpace をカラーファイルで設定するなら、
        "次の行をコメントアウト
        autocmd ColorScheme       * call ZenkakuSpace()
        autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    augroup END
    call ZenkakuSpace()
endif
"augroup highlightIdegraphicSpace
"  autocmd!
"  autocmd Colorscheme * highlight IdeographicSpace term=underline ctermbg=DarkGreen guibg=DarkGreen
"  autocmd VimEnter,WinEnter * match IdeographicSpace /　/
"augroup END
"}}} /02

"カーソル移動関連の設定
"{{{ 03
set backspace=indent,eol,start " Backspaceキーの影響範囲に制限を設けない
set whichwrap=b,s,h,l,<,>,[,]  " 行頭行末の左右移動で行をまたぐ
set scrolloff=8                " 上下8行の視界を確保
set sidescrolloff=16           " 左右スクロール時の視界を確保
set sidescroll=1               " 左右スクロールは一文字づつ行う
"}}} /03

"ファイル処理関連の設定
"{{{ 04
set confirm     " 保存されていないファイルがあるときは終了前に保存確認
set hidden      " 保存されていないファイルがあるときでも別のファイルを開くことが出来る
set autoread    " 外部でファイルに変更がされた場合は読みなおす
set nobackup    " ファイル保存時にバックアップファイルを作らない
set noswapfile  " ファイル編集中にスワップファイルを作らない
"set imdisable  "インサートモードから抜けると自動的にIMEをオフにする
set fileencodings=iso-2022-jp,euc-jp,cp932,ucs-bom,utf-8,default,latin1 " ファイルエンコーディング自動判別
"}}} /04

"検索/置換の設定
"{{{ 05
set hlsearch   " 検索文字列をハイライトする
set incsearch  " インクリメンタルサーチを行う
set ignorecase " 大文字と小文字を区別しない
set smartcase  " 大文字と小文字が混在した言葉で検索を行った場合に限り、大文字と小文字を区別する
set wrapscan   " 最後尾まで検索を終えたら次の検索で先頭に移る
set wildmenu wildmode=list:full
nnoremap <ESC><ESC> :nohlsearch<CR>
"}}} /05

"タブ・インデントの設定
"{{{ 06
set tabstop=4       " タブ文字数の指定
set expandtab       " タブをスペースに置き換える
set shiftwidth=4    " 自動タブの幅
set softtabstop=4   " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent      " 改行時に前の行のインデントを継続する
set smartindent     " 改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set smarttab        " 行頭の余白内で Tab を打ち込むと、'shiftwidth' の数だけインデントする
"}}} /06

"その他動作環境の設定
"{{{ 07
set visualbell t_vb=                "ビープ音を無効
set noerrorbells                    "エラーメッセージの表示時にビープを鳴らさない
set history=10000                   "コマンド履歴を10000記憶する
set wildmenu wildmode=list:longest,full     "コマンドラインモードでTABキーによるファイル名補完を有効にする
set clipboard=unnamed,autoselect    " clipboardにyank したテキストをクリップボードに格納する
"}}} /07

"}}}




"####################
"  プラグイン管理
"####################
"{{{

"Neobundleによるプラグイン管理開始処理
"{{{ 01
if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
NeoBundleFetch 'Shougo/neobundle.vim'
"}}} /01

"Unite関連
"{{{02
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/unite-outline'
"NeoBundle 'ujihisa/unite-colorscheme'
"}}} /02

"非同期処理用プラグイン(vimproc)
"{{{ 03
" 非同期のためのプラグイン(依存されるプラグインのため早めにLOAD)
" Recommended to install
" After install, turn shell ~/.vim/bundle/vimproc, (n,g)make -f your_machines_makefile
NeoBundle 'Shougo/vimproc.vim',{
    \'build':{
    \       'windows': 'make -f make_mingw32.mak',
    \       'cygwin': 'make -f make_cygwin.mak',
    \       'mac': 'make -f make_mac.mak'
    \   },
    \}
"}}} /03

"Vim上でSHELLを起動できるプラグイン(vimshell)
"{{{ 04
NeoBundleLazy 'Shougo/vimshell', {
  \ 'depends' : 'Shougo/vimproc',
  \ 'autoload' : {
  \   'commands' : [{ 'name' : 'VimShell', 'complete' : 'customlist,vimshell#complete'},
  \                 'VimShellExecute', 'VimShellInteractive',
  \                 'VimShellTerminal', 'VimShellPop'],
  \   'mappings' : ['<Plug>(vimshell_switch)']
  \ }}
"}}} /04

"Filer
"{{{ 05
NeoBundleLazy 'Shougo/vimfiler', {
  \ 'depends' : ["Shougo/unite.vim"],
  \ 'autoload' : {
  \   'commands' : [ "VimFilerTab", "VimFiler", "VimFilerExplorer", "VimFilerBufferDir" ],
  \   'mappings' : ['<Plug>(vimfiler_switch)'],
  \   'explorer' : 1,
  \ }}
"}}} /05

" 補完(Neocomplete)
"{{{ 06
if has('lua')
  NeoBundleLazy 'Shougo/neocomplete.vim', {
    \ 'depends' : 'Shougo/vimproc',
    \ 'autoload' : { 'insert' : 1,}
    \ }
endif
"}}} /06

"構文チェック
"{{{ 07
NeoBundle "scrooloose/syntastic"
NeoBundleLazy "nvie/vim-flake8", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"]
      \ }}
"}}} /07

"スニペット関連
"{{{ 08
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundleLazy 'Shougo/neosnippet', {
  \ 'depends' : 'Shougo/neosnippet-snippets',
  \ 'autoload' : {
  \   'insert' : 1,
  \   'filetypes' : 'snippet',
  \ }}
"}}} /08

"インデント
"{{{ 09
NeoBundle 'nathanaelkane/vim-indent-guides'
"}}} /09

"テキスト編集
"{{{ 10
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'tpope/vim-surround'
"}}} /10

"カーソル移動拡張
"{{{ 11
NeoBundle 'Lokaltog/vim-easymotion'
"}}} /11

"コマンド実行
"{{{ 12
NeoBundle 'thinca/vim-quickrun'
"}}} /12

"カラースキーマ
"{{{ 13
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'croaker/mustang-vim'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'tomasr/molokai'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'sickill/vim-monokai'
NeoBundle 'sjl/badwolf'
"}}} /13

"ステータスラインのカスタマイズ
"{{{ 14
NeoBundle 'itchyny/lightline.vim'
"}}} /14

"ステータスラインのカラースキーマ
"{{{ 15
NeoBundle 'cocopon/lightline-hybrid.vim'
"}}} /15

"Plugins for Python
"{{{ 16

"pyenvでバージョン管理されたPythonのパスを設定
let $PATH = "~/.pyenv/shims:".$PATH

"DJANGO_SETTINGS_MODULE を自動設定
NeoBundleLazy "lambdalisue/vim-django-support", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"]
      \ }}

"Pythonの補完用プラグイン Jedi-vim 追加
NeoBundleLazy "davidhalter/jedi-vim", {
  \ "autoload": {
  \   "filetypes": ["python", "python3", "djangohtml"],
  \ },
  \ } 
    " インストール後以下の処理をしておく
    " cd ~/.vim/bundle/jedi-vim/
    " git submodule update --init

"python用インデント処理
NeoBundleLazy 'hynek/vim-python-pep8-indent', {
        \ "autoload": {"insert": 1, "filetypes": ["python", "python3", "djangohtml"]}}

"python構文チェック用
NeoBundle 'nvie/vim-flake8'

"pyenv処理用プラグイン jedi-vimより後にロードされる必要がある
NeoBundleLazy "lambdalisue/vim-pyenv", {
    \ "depends": ['davidhalter/jedi-vim'],
    \ "autoload": {
    \ "filetypes": ["python", "python3", "djangohtml"]
    \ }}
"}}} /16

"Neobundleによるプラグイン管理の終了
"{{{ 17
call neobundle#end()
filetype plugin indent on
NeoBundleCheck
"}}} /17

"}}}




"####################
"  各プラグインの設定
"####################
"{{{

"unite関連
"{{{ 01

"unite,unite-outline, unite_mruの設定

"unite prefix key の設定
nnoremap [unite] <Nop>
nmap <Space>u [unite]

" インサートモードでuniteを起動
let g:unite_enable_start_insert=1
" uniteのレジスタ履歴機能の有効化
let g:unite_source_history_yank_enable =1
" uniteで管理するファイル履歴の上限を100に設定
let g:unite_source_file_mru_limit = 100
" バッファ一覧表示
nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
" ファイル一覧表示
nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> [unite]r :<C-u>Unite -buffer-name=register register<CR>
" yank, delete履歴表示
nnoremap <silent> [unite]y :<C-u>Unite history/yank<CR>
" ファイル履歴表示
nnoremap <silent> [unite]m :<C-u>Unite file_mru buffer<CR>
" アウトラインを右側に表示
" let g:unite_split_rule = 'botright'
nnoremap <silent> [unite]o :<C-u>Unite -vertical -no-quit -winwidth=40 outline<CR>
"nnoremap <silent> [unite]o :<C-u>Unite<Space>outline<CR>

" ファイルを開く時、ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')

" ファイルを開く時、ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')

" ESCキーを2回押すと終了する
au FileType unite nmap <silent> <buffer> <ESC><ESC> q
au FileType unite imap <silent> <buffer> <ESC><ESC> <ESC>q

"}}} /01

" vimfiler設定(エクスプローラー風)
"{{{ 02

" vimfilerをデフォルトのファイラーに設定
let g:vimfiler_as_default_explorer = 1
" Like Textmate icons.
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = '-'
let g:vimfiler_marked_file_icon = '*'

" 自動起動
"autocmd VimEnter * VimFiler -split -simple -winwidth=30 -toggle -no-quit

" 分割で開く
nnoremap <F2> :VimFilerBufferDir -buffer-name=explorer -split -winwidth=30 -toggle -no-quit<CR>

" 無視するファイルパターン設定(バイナリ等)
let g:vimfiler_ignore_pattern='\(^\.\|\~$\|\.pyc$\|\.[oad]$\)'

"}}} /02

"neocomplete設定
"{{{ 03

"------------------------------------
" neocomplete.vim
"------------------------------------
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  " return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()

" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

"}}} /03

"syntasticでflake8を使う設定
"{{{ 04
"pip install flake8 しておく必要がある
let g:syntastic_python_checkers = ["flake8"]
let g:syntastic_python_flake8_args="--max-line-length=120"
"}}} /04

"neosnippet設定
"{{{ 05
imap <C-s> <Plug>(neosnippet_expand_or_jump)
smap <C-s> <Plug>(neosnippet_expand_or_jump)
xmap <C-s> <Plug>(neosnippet_expand_target)
"}}} /05

"vim-indent-guides
"{{{ 06
"vimを立ち上げたときに、自動的にvim-indent-guidesをオンにする
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
" 奇数番目のインデントの色
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#444433 ctermbg=black
" 偶数番目のインデントの色
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#333344 ctermbg=darkgray
" ガイドの幅
let g:indent_guides_guide_size = 1
"}}} /06

"vim-easy-align
"{{{ 07
"Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)
"Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
"}}} /07

"vim-surround設定(特になし)
"{{{ 08
"}}} /08

"vim-easymotion
"{{{ 09

let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-s2)
xmap s <Plug>(easymotion-s2)
omap z <Plug>(easymotion-s2)
nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
let g:EasyMotion_startofline = 0
let g:EasyMotion_keys = 'lkjhgfdaoiuytrew;'
let g:EasyMotion_use_upper = 1
let g:EasyMotion_enter_jump_first = 1
let g:EasyMotion_space_jump_first = 1
hi EasyMotionTarget guifg=#80a0ff ctermfg=81

"}}} /09

"vim-quickrun
"{{{ 10
nnoremap <silent> <F5> :QuickRun -mode n<CR>
vnoremap <silent> <F5> :QuickRun -mode v<CR>
"}}} /10

"カラースキームの設定
"{{{ 11
colorscheme hybrid
"}}} /11

"lightline(pyenv設定あり)
"{{{ 12

let g:lightline = {
        \ 'colorscheme': 'hybrid',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode'
        \ }
        \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

"}}} /12

"jedi-vim (python補完)
"{{{ 13

autocmd FileType python setlocal omnifunc=jedi#completions
" docstringは表示しない
autocmd FileType python setlocal completeopt-=preview
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0

if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

"}}} /13

"}}}
