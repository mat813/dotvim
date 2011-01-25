call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" $Abso: vimrc,v 1e2c283a108a 2007/09/11 16:47:33 mat $
source $VIMRUNTIME/vimrc_example.vim

set nobackup		  " don't keep backups.
set nowritebackup	  " really don't.
set directory=$HOME/.vim/tmp//,. " keep backups elsewhere.

set history=500		  " 500 lines of history
set noincsearch		  " don't do incremental searching
set background=dark	  " dark background
set cindent		  " get indentation from C by default
set foldenable		  " do foldings
set foldmethod=marker	  " I like my folds with a marker
set sts=2 sw=2		  " two spaces tabs
set mouse=		  " always disable mouse in a terminal

set wildmenu                      " Enhanced command line completion.
set wildmode=list:longest         " Complete files like a shell.

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set scrolloff=3                   " Show 3 lines of context around the cursor.

set laststatus=2                  " Show the status line all the time
" Useful status information at bottom of screen
set statusline=[%n]\ %<%.99f\ %h%w%m%r%y\ %{exists('*CapsLockStatusline')?CapsLockStatusline():''}%=%-16(\ %l,%c-%v\ %)%P

if &term == "screen"
  set ttymouse=xterm2	  " when in a screen, use xterm2 for the mouse, in case I enable the mouse.
endif

match Todo / /		  " a non breaking space is a bad thing.

map + :noh<CR>

let g:GetLatestVimScripts_allowautoinstall=1
let g:proj_flags="imstg"
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1
let maplocalloader=','
let php_sql_query=1
let php_sync_method=0
let ruby_minlines=5000

if has("autocmd") && exists("+omnifunc")
  autocmd Filetype *
	\	if &omnifunc == "" |
	\		setlocal omnifunc=syntaxcomplete#Complete |
	\	endif
endif

runtime macros/matchit.vim

"-- from http://vimcasts.org/episodes/show-invisibles/
    " Shortcut to rapidly toggle `set list`
    nmap <leader>l :set list!<CR>
    " Use the same symbols as TextMate for tabstops and EOLs
    if &encoding ==? "utf-8"
      set listchars=tab:▸\ ,eol:¬,trail:❖
    else
      set listchars=tab:>\ ,eol:$,trail:#
    endif
"--

"-- from http://vimcasts.org/episodes/whitespace-preferences-and-filetypes/
    " Only do this part when compiled with support for autocommands
    if has("autocmd")
      " Enable file type detection
      filetype on

      " Syntax of these languages is fussy over tabs Vs spaces
      autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
      autocmd FileType yaml setlocal ts=8 sts=2 sw=2 expandtab

      " Customisations based on house-style (arbitrary)
      autocmd FileType html setlocal ts=8 sts=2 sw=2 expandtab
      autocmd FileType css setlocal ts=8 sts=2 sw=2 expandtab
      autocmd FileType javascript setlocal ts=8 sts=4 sw=4 noexpandtab

      " Treat .rss files as XML
      autocmd BufNewFile,BufRead *.rss setfiletype xml
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
    nnoremap <silent> <F5> :call Preserve("%s/\\s\\+$//e")<CR>
"--

"-- from http://vimcasts.org/episodes/working-with-tabs/
    " For mac users (using the 'apple' key)
    map <D-S-]> gt
    map <D-S-[> gT
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
