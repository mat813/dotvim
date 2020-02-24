" vim: et fdm=marker
" Garder ça au début
let g:xml_syntax_folding = 1

" from vimrc_example.vim
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Don't use Ex mode, use Q for formatting
nnoremap Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax enable
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Put these in an autocmd group, so that we can delete them easily.
  augroup MyvimrcEx
    au!

    " For all text files set 'textwidth' to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
          \ if line("'\"") > 1 && line("'\"") <= line("$") |
          \   exe "normal! g`\"" |
          \ endif

  augroup END
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
        \ | wincmd p | diffthis
endif
" end from vimrc_example.vim

set nobackup			" don't keep backups.
let &directory = $HOME . '/.config/vim/tmp/,'    . &directory " keep swap elsewhere.
let &backupdir = $HOME . '/.config/vim/backup/,' . &backupdir " keep backups elsewhere.
let &undodir =   $HOME . '/.config/vim/undo/,'   . &undodir   " keep undo elsewhere.
if !isdirectory($HOME . '/.config/vim/tmp/')
  call mkdir($HOME . '/.config/vim/tmp/', "p")
endif
if !isdirectory($HOME . '/.config/vim/backup/')
  call mkdir($HOME . '/.config/vim/backup/', "p")
endif
if !isdirectory($HOME . '/.config/vim/undo/')
  call mkdir($HOME . '/.config/vim/undo/', "p")
endif
set undofile

set viminfo='1000,f1,s100,n~/.config/vim/viminfo	" Add a bit more than the default.
set background=dark		" dark background
set cindent			" get indentation from C by default
set foldenable			" do foldings
set foldmethod=marker		" I like my folds with a marker
set sts=2 sw=2			" two spaces tabs
set modeline			" make sure modeline is enabled
set autoread			" auto reread modified files
augroup noautoread
  au!
  au BufNewFile,BufRead /Volumes/* set noautoread
augroup END

set nolazyredraw		" turn off lazy redraw

set wildmenu			" Enhanced command line completion.
set wildmode=list:full		" Complete files like a shell.

set ignorecase			" Case-insensitive searching.
set smartcase			" But case-sensitive if expression contains a capital letter.

set scrolloff=3			" Show 3 lines of context around the cursor.

if &term == "screen"
  set ttymouse=xterm2		" when in a screen, use xterm2 for the mouse, in case I enable the mouse.
endif

match Todo / /			" a non breaking space is a bad thing.

let mapleader = " "		" have a <Space> for <Leader>.

" No Help, please.
nnoremap <F1> <Esc>

nnoremap <silent> + :noh<CR>

call plug#begin('~/.config/vim/plugged') " {{{

Plug 'Absolight/Bird-Syntax'
Plug 'Absolight/vim-bind'
Plug 'Lokaltog/vim-easymotion'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'ap/vim-css-color'
Plug 'cakebaker/scss-syntax.vim'
Plug 'chrisbra/NrrwRgn'
Plug 'chriskempson/base16-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'digitaltoad/vim-pug'
Plug 'ervandew/supertab'
Plug 'garbas/vim-snipmate'
Plug 'godlygeek/tabular'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'junegunn/vim-plug' " Pour la doc
Plug 'kana/vim-textobj-user'
Plug 'kchmck/vim-coffee-script'
Plug 'kien/tabman.vim'
Plug 'kusabashira/mojo.vim'
Plug 'leafOfTree/vim-vue-plugin'
Plug 'lepture/vim-jinja'
Plug 'mbbill/undotree'
Plug 'mileszs/ack.vim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'nono/vim-handlebars'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'python-mode/python-mode'
Plug 'saltstack/salt-vim'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 't9md/vim-choosewin'
Plug 'tommcdo/vim-exchange'
Plug 'tomtom/tcomment_vim'
Plug 'tomtom/tlib_vim'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-haml'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-scriptease'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-ruby/vim-ruby'
Plug 'vim-scripts/Align'
Plug 'vim-scripts/AutoComplPop'
Plug 'vim-scripts/JavaScript-Indent'
Plug 'vim-scripts/Visual-Mark'
Plug 'vim-scripts/ikiwiki-nav'
Plug 'vim-scripts/matchit.zip'
Plug 'vim-scripts/ruby-matchit'
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug '~/.config/vim/bundle/augeas'

call plug#end() " }}}

" Fugitive.vim {{{1
if has("autocmd")
  " Auto-close fugitive buffers
  autocmd BufReadPost fugitive://* set bufhidden=delete

  " Navigate up one level from fugitive trees and blobs
  autocmd User fugitive
        \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
        \   nnoremap <buffer> .. :edit %:h<CR> |
        \ endif

endif

" Lightline {{{1

let g:lightline = {
      \ 'colorscheme': 'solarized',
      \ 'active': { 'left': [ [ 'mode', 'paste' ],
      \                       [ 'fugitive', 'filename' ] ],
      \             'right': [ [ 'syntastic', 'lineinfo' ],
      \                        [ 'filetype', 'fileencoding' ],
      \                        [ 'whitespace' ] ],
      \ },
      \ 'inactive': { 'left': [ ['mode', 'paste'],
      \                         [ 'fugitive', 'filename' ] ],
      \               'right': []
      \ },
      \ 'component_function': {
      \                         'readonly'     : 'MyReadonly',
      \                         'modified'     : 'MyModified',
      \                         'fugitive'     : 'MyFugitive',
      \                         'filename'     : 'MyFilename',
      \                         'fileencoding' : 'MyFileencoding',
      \                         'filetype'     : 'MyFiletype',
      \                         'mode'         : 'MyMode',
      \                         'lineinfo'     : 'MyLineinfo',
      \                         'whitespace'   : 'MyWhitespace',
      \ },
      \ 'component_expand': {
      \                       'syntastic': 'SyntasticStatuslineFlag',
      \ },
      \ 'component_type': {
      \                     'syntastic': 'error',
      \ },
      \ 'separator': { 'left': '▶', 'right': '◀' },
      \ 'subseparator': { 'left': '»', 'right': '«' },
      \ }

function! MyMode() " {{{2
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERD Tree' :
        \ &ft == 'help' ? 'HELP' :
        \ &ft == 'unite' ? 'Unite' :
        \ &ft == 'vimfiler' ? 'VimFiler' :
        \ &ft == 'vimshell' ? 'VimShell' : lightline#mode()
        "\ winwidth(0) > 55 ? lightline#mode() : ''
endfunction

function! MyFugitive() " {{{2
  if winwidth(0) > 6 && expand('%:t') !~? 'Tagbar\|Gundo\|NERD'
        \ && &ft !~? 'vimfiler' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? '⎇ '._ : ''
  endif
  return ''
endfunction

function! MyReadonly() " {{{2
  return &readonly ? '✗' : ''
endfunction

function! MyModified() " {{{2
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '✚' : &modifiable ? '' : '-'
endfunction

function! MyFilename() " {{{2
  let fname = expand('%:t')
  return fname == 'ControlP' ? g:lightline.ctrlp_item :
        \ fname == '__Tagbar__' ? g:lightline.fname :
        \ fname =~ '__Gundo\|NERD_tree' ? '' :
        \ &ft == 'help' ? '' :
        \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft == 'unite' ? unite#get_status_string() :
        \ &ft == 'vimshell' ? vimshell#get_status_string() :
        \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyWhitespace() " {{{2
  let [lnum,cnum] = searchpos('\s\+$', 'nw')
  let trailing = lnum != 0 && cnum != 0 ? '⎵ :'.lnum : ''
  let tabs = search('^\t', 'nw') != 0
  let spaces = search('^ ', 'nw') != 0
  return (tabs && spaces ? '[mixed]' : '') . trailing
endfunction

function! MyFiletype() " {{{2
  let ftype = (strlen(&filetype) ? &filetype : 'undef')
  return winwidth(0) >= strlen(MyMode()) + strlen(MyFugitive()) + strlen(MyFilename()) + 24 + 32 ? ftype : ''
endfunction

function! MyFileencoding() " {{{2
  let fileenc = (strlen(&fenc) ? &fenc : &enc) . ('unix' == &fileformat ? '' : '(' . &fileformat . ')')
  return winwidth(0) >= strlen(MyMode()) + strlen(MyFugitive()) + strlen(MyFilename()) + 24 + 24 ? fileenc : ''
endfunction

function! MyLineinfo() " {{{2
  let l:cl = line(".")
  let l:ll = line("$")
  let l:cc = col(".")
  let l:fm = printf("¶ %%0%dd/%%d → %%03d", strlen(l:ll))
  let l:li = printf(l:fm, l:cl, l:ll, l:cc)
  return expand('%:t') !~? 'Tagbar\|Gundo\|NERD'
        \ && winwidth(0) >= strlen(MyMode()) + strlen(MyFugitive()) + strlen(MyFilename()) + 24 + 16 ? l:li : ''
endfunction

" ControlP {{{1
let g:ctrlp_show_hidden = 1
let g:ctrlp_cache_dir = $HOME.'/.config/vim/tmp/ctrlp'
let g:ctrlp_extensions = ['autoignore']

let g:ctrlp_status_func = {
      \ 'main': 'CtrlPStatusFunc_1',
      \ 'prog': 'CtrlPStatusFunc_2',
      \ }

function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked) " {{{2
  let g:lightline.ctrlp_regex = a:regex
  let g:lightline.ctrlp_prev = a:prev
  let g:lightline.ctrlp_item = a:item
  let g:lightline.ctrlp_next = a:next
  return lightline#statusline(0)
endfunction

function! CtrlPStatusFunc_2(str) "{{{2
  return lightline#statusline(0)
endfunction

" vim-vue-plugin {{{1
let g:vim_vue_plugin_use_pug=1
let g:vim_vue_plugin_use_sass=1
let g:vim_vue_plugin_use_coffee=1

" vim-easy-align {{{1
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" limelight {{{1
nmap <Leader>l <Plug>(Limelight)
xmap <Leader>l <Plug>(Limelight)

" goyo {{{1
function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowmode
  set noshowcmd
  set scrolloff=999
  Limelight
  " ...
endfunction

function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showmode
  set showcmd
  set scrolloff=5
  Limelight!
  " ...
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Rails {{{1
if has("autocmd")
  augroup MyRails
    au!

    autocmd User Rails Rnavcommand cell app/cells -glob=**/* -suffix=
    autocmd User Rails Rnavcommand feature features -glob=**/* -suffix=.feature
    autocmd User Rails Rnavcommand step features -glob=**/* -suffix=_steps.rb
    autocmd User Rails map <Leader>m  :Rmodel
    autocmd User Rails map <Leader>tm :RTmodel
    autocmd User Rails map <Leader>sm :RSmodel
    autocmd User Rails map <Leader>c  :Rcontroller
    autocmd User Rails map <Leader>tc :RTcontroller
    autocmd User Rails map <Leader>sc :RScontroller
    autocmd User Rails map <Leader>C  :Rcell
    autocmd User Rails map <Leader>tC :RTcell
    autocmd User Rails map <Leader>sC :RScell
    autocmd User Rails map <Leader>v  :Rview
    autocmd User Rails map <Leader>tv :RTview
    autocmd User Rails map <Leader>sv :RSview
    autocmd User Rails map <Leader>h  :Rhelper
    autocmd User Rails map <Leader>th :RThelper
    autocmd User Rails map <Leader>sh :RShelper
    autocmd User Rails map <Leader>j  :Rjavascript
    autocmd User Rails map <Leader>tj :RTjavascript
    autocmd User Rails map <Leader>sj :RSjavascript
    autocmd User Rails map <Leader>s  :Rstylesheet
    autocmd User Rails map <Leader>ts :RTstylesheet
    autocmd User Rails map <Leader>ss :RSstylesheet
    " autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes
    " autocmd User Rails map <Leader>g  :Rconfig
    " autocmd User Rails map <Leader>sg :RSconfig
    " autocmd User Rails map <Leader>tg :RTconfig
  augroup END
endif
"--

" indentLine {{{1
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
noremap <silent> <Leader>i :IndentLinesToggle<CR>

"-- from http://vimcasts.org/episodes/show-invisibles/ {{{1
" Shortcut to rapidly toggle `set list`
nnoremap <silent> <leader>l :set list!<CR>
" Use the same symbols as TextMate for tabstops and EOLs
if &encoding ==? "utf-8"
  " \u25b8  \u00b6  \u2423 \u00ac  \u21c9   \u21c7
  set listchars=tab:▸–,eol:¶,trail:␣,nbsp:¬,extends:⇉,precedes:⇇
else
  set listchars=tab:>-,eol:$,trail:#,nbsp:#,extends:>,precedes:<
endif

"-- from http://vimcasts.org/episodes/whitespace-preferences-and-filetypes/ {{{1
" Only do this part when compiled with support for autocommands
if has("autocmd")
  " Enable file type detection
  filetype on

  augroup MyWhiteSpaceAndFiletypes
    au!

    " Syntax of these languages is fussy over tabs Vs spaces
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType yaml setlocal ts=8 sts=2 sw=2 expandtab
    autocmd FileType coffee setlocal expandtab

    " Customisations based on house-style (arbitrary)
    autocmd FileType html setlocal ts=8 sts=2 sw=2 expandtab
    autocmd FileType css setlocal ts=8 sts=2 sw=2 expandtab
    autocmd FileType javascript setlocal ts=8 sts=4 sw=4 noexpandtab

    " Treat .rss files as XML
    autocmd BufNewFile,BufRead *.rss setfiletype xml
  augroup END
endif

"-- from http://vimcasts.org/episodes/tidying-whitespace/ {{{1
function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction
nnoremap <silent> <Leader>$ :call Preserve("%s/\\s\\+$//e")<CR>
nnoremap <silent> <Leader>= :call Preserve("normal gg=G")<CR>

"-- from http://vimcasts.org/episodes/working-with-tabs/ {{{1
" For mac users (using the 'apple' key)
map <D-S-]> gt
map <D-S-[> gT
map <D-A-Right> gt
map <D-A-Left> gT
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-0> :tablast<CR>

"-- from http://vimcasts.org/episodes/soft-wrapping-text/ {{{1
if &encoding ==? "utf-8"
  set showbreak=…
else
  set showbreak=...
endif

"-- from http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/ {{{1
if has("autocmd")
  augroup MyFugitive
    au!

    autocmd User fugitive
          \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)' |
          \   nnoremap <buffer> .. :edit %:h<CR> |
          \ endif
    autocmd BufReadPost fugitive://* set bufhidden=delete
  augroup END
endif

" garder ça après tous 1}}}

let g:GetLatestVimScripts_allowautoinstall=1
let g:proj_flags="imstg"
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let g:syntastic_auto_jump=1
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_balloons = 1
let g:syntastic_ruby_checkers          = ['rubocop', 'mri']
let g:gundo_right = 1
let g:session_autosave = 'no'
let maplocalloader=','
let php_sql_query=1
let php_sync_method=0
let ruby_minlines=5000

if has("autocmd") && exists("+omnifunc") " {{{1
  augroup MyOmnifunc
    au!
    autocmd Filetype *
          \	if &omnifunc == "" |
          \		setlocal omnifunc=syntaxcomplete#Complete |
          \	endif
  augroup END
endif " 1}}}

let g:SuperTabNoCompleteBefore=['\<']
let g:SuperTabNoCompleteAfter=['^', '\s', '\W']

nnoremap <silent> <leader>u :UndotreeToggle<CR>

runtime macros/matchit.vim

" FreeBSD docs {{{
if has("autocmd")
  augroup MyXML
    au!
    autocmd FileType xml setlocal sts=2 sw=2 tw=70 cc+=1 fo=tcq2l noet formatexpr=
    autocmd FileType docbk setlocal sts=2 sw=2 tw=70 cc+=1 fo=tcq2l noet formatexpr=
  augroup END
endif " }}}

let g:syntastic_mode_map = { 'mode': 'active',
      \ 'active_filetypes': [],
      \ 'passive_filetypes': ['xml', 'docbk'] }

let g:snippets_dir = "$HOME/.vim/bundle/snipmate.vim/snippets/,$HOME/.vim/snippets/"

source $HOME/.vim/colors.vim

let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

" togglebg#map map en normal, visual et input, faut virer input.
call togglebg#map("<Leader>b")
iunmap <Leader>b

noremap <silent> <Leader>n :set nu!<CR>
noremap <silent> <Leader>w :set wrap!<CR>

map <F10> <Leader>hlt

let g:NERDTreeDirArrows = &encoding ==? "utf-8"

" MyGit/SVN {{{
if has("autocmd")
  " augroup MyGIT
  "   au!
  "   " need to escape <CR> and <ESC>
  "   autocmd BufReadPost COMMIT_EDITMSG exe "r ~/.subversion-template"
  "   autocmd FileType svn setlocal sts=8 sw=7 tw=70 cc+=1 fo=tcq2l noet
  " augroup END
  augroup MySVN
    au!
    " need to escape <CR> and <ESC>
    "autocmd BufReadPost svn-commit* exe "normal gg/Sponsored by:\<CR>AAbsolight\<ESC>gg"
    autocmd FileType svn setlocal sts=8 sw=7 tw=70 cc+=1 fo=tcq2l noet
  augroup END
endif " }}}

let g:pymode_rope_regenerate_on_write = 0

augroup MyEPUB " MyEPUB {{{
  au!
  au BufReadCmd   *.epub		call zip#Browse(expand("<amatch>"))
augroup END " }}}

if executable('ag')
  let g:ackprg = 'ag --nogroup --nocolor --column'
endif

" Abbrev {{{1
augroup MyAbbrevs
  au!
  au FileType gitcommit inoreabbrev -> →
  au FileType gitcommit inoreabbrev kato tkato432 yahoo com
  au FileType mail inoreabbrev cdlt Cordialement,
augroup END

" Shortcuts for opening file in same directory as current file {{{1
cnoremap <expr> %%  getcmdtype() == ':' ? escape(expand('%:h'), ' \').'/' : '%%'
nmap <leader>ew :e %%
nmap <leader>es :sp %%
nmap <leader>ev :vsp %%
nmap <leader>et :tabe %%

" ChooseWin plugin {{{1
nmap  -  <Plug>(choosewin)
let g:choosewin_overlay_enable = 1

" :CloseHiddenBuffers {{{1
" Wipe all buffers which are not active (i.e. not visible in a window/tab)
" Using elements from each of these:
"   http://stackoverflow.com/questions/2974192
"   http://stackoverflow.com/questions/1534835
command! -nargs=* Only call CloseHiddenBuffers()
function! CloseHiddenBuffers()
  " figure out which buffers are visible in any tab
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor
  " close any buffer that are loaded and not visible
  let l:tally = 0
  for b in range(1, bufnr('$'))
    if bufloaded(b) && !has_key(visible, b)
      let l:tally += 1
      exe 'bw ' . b
    endif
  endfor
  echon "Deleted " . l:tally . " buffers"
endfun " 1}}}

noremap <Leader>c :set cuc!<CR>
noremap <Leader>C :set cul!<CR>

"nnoremap :sr1 normal :edit sftp://sr1.absolight.com/out

let g:pymode_rope = 0

