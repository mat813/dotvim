" $Abso: vimrc,v 1e2c283a108a 2007/09/11 16:47:33 mat $
source $VIMRUNTIME/vimrc_example.vim

set nobackup
set noincsearch
set bg=dark
set cindent
set foldenable
set foldmethod=marker
set sts=2 sw=2
set cindent
set history=500
set mouse=
if has("gui_running")
  set encoding=utf-8
endif
if &term == "screen"
  set ttymouse=xterm2
endif

helptags ~/.vim/doc

match Todo / /

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
