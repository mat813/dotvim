execute pathogen#infect()

" from vimrc_example.vim
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands

" Don't use Ex mode, use Q for formatting
nnoremap Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
  set incsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

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

else

  set autoindent		" always set autoindenting on

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
set nowritebackup		" really don't.
set directory=$HOME/.vim/tmp//,. " keep backups elsewhere.
set undodir=$HOME/.vim/undo//,.
set undofile

set viminfo=%50,'1000,/500,:500,@500,f1,s100	" Add a bit more than the default.
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

set nolazyredraw		" turn of lazy redraw

set wildmenu			" Enhanced command line completion.
set wildmode=list:full		" Complete files like a shell.

set ignorecase			" Case-insensitive searching.
set smartcase			" But case-sensitive if expression contains a capital letter.

set scrolloff=3			" Show 3 lines of context around the cursor.

set laststatus=2		" Show the status line all the time

" Useful status information at bottom of screen
set statusline=%#StatusLineNC#[%n]\ %#StatusLine#%<%.99f%*\ %Y%M%R%H
set statusline+=%{fugitive#statusline()}
set statusline+=%#StatusLine#%{SyntasticStatuslineFlag()}%*
if exists('$rvm_path')
  set statusline+=%{rvm#statusline()}
end
set statusline+=%=%-16(\ [%B]\ %l,%c%V\ %)%P

if &term == "screen"
  set ttymouse=xterm2		" when in a screen, use xterm2 for the mouse, in case I enable the mouse.
endif

match Todo / /			" a non breaking space is a bad thing.

let mapleader = " "		" have a <Space> for <Leader>.

" No Help, please.
nnoremap <F1> <Esc>

nnoremap + :noh<CR>

let g:GetLatestVimScripts_allowautoinstall=1
let g:proj_flags="imstg"
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let g:syntastic_auto_jump=1
let g:syntastic_auto_loc_list=1
let g:syntastic_enable_balloons = 1
let g:gundo_right = 1
let maplocalloader=','
let php_sql_query=1
let php_sync_method=0
let ruby_minlines=5000

if has("autocmd") && exists("+omnifunc")
  augroup MyOmnifunc
    au!
    autocmd Filetype *
          \	if &omnifunc == "" |
          \		setlocal omnifunc=syntaxcomplete#Complete |
          \	endif
  augroup END
endif

nnoremap <F5> :GundoToggle<CR>

runtime macros/matchit.vim

"-- from http://vimcasts.org/episodes/show-invisibles/
" Shortcut to rapidly toggle `set list`
nnoremap <leader>l :set list!<CR>
" Use the same symbols as TextMate for tabstops and EOLs
if &encoding ==? "utf-8"
  set listchars=tab:▸–,eol:¶,trail:❖,nbsp:¬,extends:»,precedes:«
else
  set listchars=tab:>-,eol:$,trail:#,nbsp:#,extends:>,precedes:<
endif
"--

"-- from http://vimcasts.org/episodes/whitespace-preferences-and-filetypes/
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
" --

"-- from http://vimcasts.org/episodes/tidying-whitespace/
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
nnoremap <Leader>$ :call Preserve("%s/\\s\\+$//e")<CR>
nnoremap <Leader>= :call Preserve("normal gg=G")<CR>
"--

"-- from http://vimcasts.org/episodes/working-with-tabs/
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
"--

"-- from http://vimcasts.org/episodes/soft-wrapping-text/
if &encoding ==? "utf-8"
  set showbreak=…
else
  set showbreak=...
endif
"--

"-- Rails
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

"-- from http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
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
"--

let g:snippets_dir = "$HOME/.vim/bundle/snipmate.vim/snippets/,$HOME/.vim/snippets/"

source $HOME/.vim/colors.vim

let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

" ControlP
let g:ctrlp_show_hidden = 1
let g:ctrlp_cache_dir = $HOME.'/.vim/tmp/ctrlp'

" togglebg#map map en normal, visual et input, faut virer input.
call togglebg#map("<Leader>b")
iunmap <Leader>b

noremap <Leader>n :set nu!<CR>
noremap <Leader>w :set wrap!<CR>

map <F10> <Leader>hlt

" Teach vim how to open epub files
augroup EPUB
  au!
  au BufReadCmd   *.epub		call zip#Browse(expand("<amatch>"))
augroup END

let g:NERDTreeDirArrows = &encoding ==? "utf-8"

if executable('ag')
  let g:ackprg = 'ag --nogroup --nocolor --column'
endif

" hardmode.
nnoremap <leader>h <Esc>:call EasyMode()<CR>
nnoremap <leader>H <Esc>:call HardMode()<CR>
"
