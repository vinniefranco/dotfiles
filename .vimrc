
" Environment {
  set nocompatible        " must be first line

  " Setup Bundle Support {
  filetype on
  filetype off
  set lazyredraw
  set rtp+=~/.vim/bundle/vundle
  call vundle#rc()
" }

" Bundles {
  if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
  endif
" }

" General {
  set background=dark         " Assume a dark background
  filetype plugin indent on   " Automatically detect file types.
  syntax on                   " syntax highlighting
  set mouse=a                 " automatically enable mouse usage
  set encoding=utf-8
  scriptencoding utf-8
  autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
  " always switch to the current file directory.

  set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
  set virtualedit=onemore         " allow for cursor beyond last character
  set history=100                 " Store a ton of history (default is 20)
  set hidden                      " allow buffer switching without saving

  " Setting up the directories {
  set backup                      " backups are nice ...
  if has('persistent_undo')
    set undofile                "so is persistent undo ...
    set undolevels=500         "maximum number of changes that can be undone
    set undoreload=500         "maximum number lines to save for undo on a buffer reload
  endif

  set tabpagemax=15               " only show 15 tabs
  set showmode                    " display the current mode
  set cursorline                  " highlight current line
  set backspace=indent,eol,start  " backspace for dummies
  set linespace=0                 " No extra spaces between rows
  set nu                          " Line numbers on
  set showmatch                   " show matching brackets/parenthesis
  set hlsearch                    " highlight search terms
  set winminheight=0              " windows can be 0 line high
  set ignorecase                  " case insensitive search
  set smartcase                   " case sensitive when uc present
  set wildmenu                    " show list instead of just completing
  set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
  set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
  set scrolljump=5                " lines to scroll when cursor leaves screen
  set scrolloff=3                 " minimum lines to keep above and below cursor
  set list
  set listchars=tab:,.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace

" }

" Formatting {
  set nowrap                                    " wrap long lines
  set autoindent                                " indent at the same level of the previous line
  set expandtab                                 " tabs are spaces, not tabs
  set pastetoggle=<F12>                         " pastetoggle (sane indentation on pastes)
  set listchars=tab:``,trail:`,extends:#,nbsp:` " Highlight problematic whitespace"
  set shiftwidth=2                              " use indents of 2 spaces"
  set tabstop=2                                 " an indentation every 2 columns"
  set softtabstop=2                             " let backspace delete indent"
  " Remove trailing whitespaces and ^M chars
  autocmd FileType c,cpp,java,php,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))
  autocmd BufNewFile,BufRead *.jst.ejs set filetype=html
  au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,*.json_builder,config.ru,.caprc,.irbrc,irb_tempfile*} set ft=ruby
  " Special definitions
  autocmd FileType php setlocal shiftwidth=2 tabstop=2 noexpandtab
  autocmd FileType html setlocal shiftwidth=4 tabstop=4 noexpandtab

  set notimeout      " timeout on mappings and key bindings"
  set ttimeout       " timeout on mappings"
  set timeoutlen=50

" }

" Key (re)Mappings {

  "The default leader is '\', but many people prefer ',' as it's in a standard
  "location
  let mapleader = ','

  " Easier moving in tabs and windows
  map <C-J> <C-W>j<C-W>_
  map <C-K> <C-W>k<C-W>_
  map <C-L> <C-W>l<C-W>_
  map <C-H> <C-W>h<C-W>_

  " Wrapped lines goes down/up to next row, rather than next line in file.
  nnoremap j gj
  nnoremap k gk

  " The following two lines conflict with moving to top and bottom of the
  " screen
  " If you prefer that functionality, comment them out.
  map <S-H> gT
  map <S-L> gt

  " Stupid shift key fixes
  if has("user_commands")
    command! -bang -nargs=* -complete=file E e<bang> <args>
    command! -bang -nargs=* -complete=file W w<bang> <args>
    command! -bang -nargs=* -complete=file Wq wq<bang> <args>
    command! -bang -nargs=* -complete=file WQ wq<bang> <args>
    command! -bang Wa wa<bang>
    command! -bang WA wa<bang>
    command! -bang Q q<bang>
    command! -bang QA qa<bang>
    command! -bang Qa qa<bang>
  endif

  cmap Tabe tabe

  " Yank from the cursor to the end of the line, to be consistent with C and D.
  nnoremap Y y$

  " Quickly turn a string back to = into an array
  nmap <silent> <leader>ta vF=l<Esc>:s/\%V\S\+/"&",/g<CR>A<BS><Esc>vF=2lgS[JJ:let @/ = ""<CR>

  " Break comma delimited strings to newline at cursor
  nmap <silent> <leader>br :s/, /\=",\r " . substitute(substitute(getline('.'), " :.*$", "", "g"), ".", " ", "g")/g<CR>

  "clearing highlighted search
  nmap <silent> <leader>/ :nohlsearch<CR>

  " Shortcuts
  " Change Working Directory to that of the current file
  cmap cwd lcd %:p:h
  cmap cd. lcd %:p:h

  " visual shifting (does not exit Visual mode)
  vnoremap < <gv
  vnoremap > >gv

  " Fix home and end keybindings for screen, particularly on mac
  " - for some reason this fixes the arrow keys too. huh.
  map [F $
  imap [F $
  map [H g0
  imap [H g0

  " For when you forget to sudo.. Really Write the file.
  cmap w!! w !sudo tee % >/dev/null

  " Some helpers to edit mode
  " http://vimcasts.org/e/14
  cnoremap %% <C-R>=expand('%:h').'/'<cr>
  map <leader>ew :e %%
  map <leader>es :sp %%
  map <leader>ev :vsp %%
  map <leader>et :tabe %%

  " Adjust viewports to the same size
  map <Leader>= <C-w>=

  " Easier horizontal scrolling
  map zl zL
  map zh zH
" }

" Plugins {


  " Misc {
    let g:NERDShutUp=1
    let b:match_ignorecase = 1
  " }

  " AutoCloseTag {
    " Make it so AutoCloseTag works for xml and xhtml files as well
    au FileType xhtml,xml ru ftplugin/html/autoclosetag.vim
    nmap <Leader>ac <Plug>ToggleAutoCloseMappings
  " }

  " NerdTree {
    map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>
    map <leader>e :NERDTreeFind<CR>
    nmap <leader>nt :NERDTreeFind<CR>

    let NERDTreeShowBookmarks=1
    let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=1
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1
  " }

  " Tabularize {
      nmap <Leader>a> :Tabularize /=><CR>
      vmap <Leader>a> :Tabularize /=><CR>
      nmap <Leader>a= :Tabularize /=<CR>
      vmap <Leader>a= :Tabularize /=<CR>
      nmap <Leader>a: :Tabularize /:<CR>
      vmap <Leader>a: :Tabularize /:<CR>
      nmap <Leader>a:: :Tabularize /:\zs<CR>
      vmap <Leader>a:: :Tabularize /:\zs<CR>
      nmap <Leader>a , :Tabularize / , <CR>
      vmap <Leader>a , :Tabularize / , <CR>
      nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
      vmap <Leader>a<Bar> :Tabularize /<Bar><CR>

      " The following function automatically aligns when typing a
      " supported character
      inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

      function! s:align()
        let p = '^\s*|\s.*\s|\s*$'
        if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
          let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
          let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
          Tabularize/|/l1
          normal! 0
          call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
        endif
      endfunction

  " }

  " Buffer explorer {
    nmap <leader>b :BufExplorer<CR>
  " }

  " JSON {
    nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
  " }

  " PyMode {
    let g:pymode_lint_checker = "pyflakes"
  " }

  " PythonMode {
    " Disable if python support not present
    if !has('python')
      let g:pymode = 1
    endif
  " }

  " Fugitive {
    nnoremap <silent> <leader>gs :Gstatus<CR>
    nnoremap <silent> <leader>gd :Gdiff<CR>
    nnoremap <silent> <leader>gc :Gcommit<CR>
    nnoremap <silent> <leader>gb :Gblame<CR>
    nnoremap <silent> <leader>gl :Glog<CR>
    nnoremap <silent> <leader>gp :Git push<CR>
  "}

  " neocomplcache {
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_enable_camel_case_completion = 1
    let g:neocomplcache_enable_smart_case = 1
    let g:neocomplcache_enable_underbar_completion = 1
    let g:neocomplcache_min_syntax_length = 3
    let g:neocomplcache_enable_auto_delimiter = 1
    let g:neocomplcache_max_list = 15
    let g:neocomplcache_auto_completion_start_length = 3
    let g:neocomplcache_force_overwrite_completefunc = 1
    let g:neocomplcache_snippets_dir='~/.vim/bundle/snipmate-snippets/snippets'

    " AutoComplPop like behavior.
    let g:neocomplcache_enable_auto_select = 1

    " SuperTab like snippets behavior.
    imap  <silent><expr><tab>  neocomplcache#sources#snippets_complete#expandable() ? "\<plug>(neocomplcache_snippets_expand)" : (pumvisible() ? "\<c-e>" : "\<tab>")
    smap  <tab>  <right><plug>(neocomplcache_snippets_jump) 

    " Plugin key-mappings.
    " Ctrl-k expands snippet & moves to next position
    " <CR> chooses highlighted value
    imap <C-k>     <Plug>(neocomplcache_snippets_expand)
    smap <C-k>     <Plug>(neocomplcache_snippets_expand)
    inoremap <expr><C-g>   neocomplcache#undo_completion()
    inoremap <expr><C-l>   neocomplcache#complete_common_string()
    inoremap <expr><CR>    neocomplcache#complete_common_string()

    " <CR>: close popup
    " <s-CR>: close popup and save indent.
    inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup()"\<CR>" : "\<CR>"
    inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "\<CR>"

    " <TAB>: completion.
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><s-TAB>  pumvisible() ? "\<C-p>" : "\<TAB>"

    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplcache#close_popup()

    " Make splits a bit more managable.
    nnoremap <C-Left> :vs<CR><C-w>l
    nnoremap <C-Right> :split<CR><C-w>j
    nnoremap <C-Up> :bn<CR>
    nnoremap <C-Down> :bp<CR>
    vmap <Left> <gv
    vmap <Right> >gv


    " Define keyword.
    if !exists('g:neocomplcache_keyword_patterns')
      let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns['default'] = '\h\w*'


    " Enable heavy omni completion.
    if !exists('g:neocomplcache_omni_patterns')
      let g:neocomplcache_omni_patterns = {}
    endif
    let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
    let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
    let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

    " For snippet_complete marker.
    if has('conceal')
     set conceallevel=2 concealcursor=i
    endif

 " }

 " UndoTree {
   nnoremap <c-u> :UndotreeToggle<CR>
 " }

 " Show 80th column.
   if exists('+colorcolumn')
     set colorcolumn=80
   else
     au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
   endif

  " Airline {
    let g:syntastic_ignore_files=['\.html$', '\c\.h$', '\.css$']
    let g:airline_powerline_fonts=1
    set laststatus=2
  " }

  " vim-rspec Mappings {
    let g:rspec_command = 'call Send_to_Tmux("spring rspec {spec}\n")'
    map <Leader>t :call RunCurrentSpecFile()<CR>
    map <Leader>s :call RunNearestSpec()<CR>
    map <Leader>l :call RunLastSpec()<CR>
    map <Leader>a :call RunAllSpecs()<CR>
  " }
" }


 " Functions {

function! InitializeDirectories()
  let separator = "."
  let parent = $HOME
  let prefix = '.vim'
  let dir_list = {
              \ 'backup': 'backupdir',
              \ 'views': 'viewdir',
              \ 'swap': 'directory' }

  if has('persistent_undo')
    let dir_list['undo'] = 'undodir'
  endif

  for [dirname, settingname] in items(dir_list)
    let directory = parent . '/' . prefix . dirname . "/"
    if exists("*mkdir")
      if !isdirectory(directory)
        call mkdir(directory)
      endif
    endif
    if !isdirectory(directory)
      echo "Warning: Unable to create backup directory: " . directory
      echo "Try: mkdir -p " . directory
    else
      let directory = substitute(directory, " ", "\\\\ ", "g")
      exec "set " . settingname . "=" . directory
    endif
  endfor
endfunction
call InitializeDirectories()

function! NERDTreeInitAsNeeded()
  redir => bufoutput
  buffers!
  redir END
  let idx = stridx(bufoutput, "NERD_tree")
  if idx > -1
    NERDTreeMirror
    NERDTreeFind
    wincmd l
  endif
endfunction
" }

" Ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_reuse_window='startify'
let g:ctrlp_extensions=['funky']
if executable('ag')
  let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
endif
let g:ctrlp_working_path_mode = 'ra'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.map
set wildignore+=*/doc/*,*/public/assets/*


" ctrl.p like usage of Unite.vim
""call unite#filters#matcher_default#use(['matcher_fuzzy'])
""call unite#filters#sorter_default#use(['sorter_rank'])
""call unite#set_profile('files', 'smartcase', 1)

let g:unite_data_directory='~/.vim/.cache/unite'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
let g:unite_source_file_rec_max_cache_files=5000
let g:unite_prompt='» '
if executable('ag')
  set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
  set grepformat=%f:%l:%c:%m
  let g:unite_source_grep_command='ag'
  let g:unite_source_grep_default_opts='--nocolor --nogroup --hidden'
  let g:unite_source_grep_recursive_opt=''
elseif executable('ack')
  let g:unite_source_grep_command='ack'
  let g:unite_source_grep_default_opts='--no-heading --no-color -a'
  let g:unite_source_grep_recursive_opt=''
endif

" LustyJuggler buffer switching
nnoremap <space>s :Unite -quick-match buffer<cr>

" Ack.vim like searching
nnoremap <space>f :Unite grep:.<cr>
let g:agprg="/usr/local/bin/ag --column"

"Simpler vimgrep.
"Usage  ':Gf <REGEX> <DIRECTORY_SCOPE(OPTIONAL)> <FILE_EXT(OPTIONAL)>'
function! GFind(...)
  let regEx = a:1 . 'gj'
  let dir   = a:0 >= 2 ? a:2 : './'
  let ext   = a:0 >= 3 ? a:3 : 'php'

  execute(':noautocmd vimgrep ' . regEx . ' ' . dir . '**/*.' .ext)
  execute(':cw')
endfunction

:command! -complete=dir -nargs=* Ff call GFind(<f-args>)

" And finally. Make it pretty.
set ttyfast
set t_Co=256
set background=dark
let g:seoul256_background = 234
colorscheme Tomorrow-Night
set guifont=Envy\ Code\ R\ for\ Powerline:h12
