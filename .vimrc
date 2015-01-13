set nocompatible  " must be first line
set lazyredraw    " adds some needed speed in iTerm2
set noautochdir   " don't change dir when you open new files

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

set spell spelllang=en_us
filetype plugin indent on   " Automatically detect file types.
syntax on                   " syntax highlighting
set encoding=utf-8
scriptencoding utf-8

set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
set history=100                 " Store a ton of history (default is 20)
set hidden                      " allow buffer switching without saving

" Setting up the directories
set backup                   " backups are nice ...
if has('persistent_undo')
  set undofile               "so is persistent undo ...
  set undolevels=500         "maximum number of changes that can be undone
  set undoreload=500         "maximum number lines to save for undo on a buffer reload
endif

set showmode                    " display the current mode
set colorcolumn=80
set cursorline                  " highlight current line
set backspace=indent,eol,start  " backspace for dummies
set linespace=0                 " No extra spaces between rows
set relativenumber
set number
set showmatch                   " show matching brackets/parenthesis
set hlsearch                    " highlight search terms
set winminheight=0              " windows can be 0 line high
set smartcase                   " case sensitive when uc present
set wildmenu                    " show list instead of just completing
set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " backspace and cursor keys wrap to
set scrolljump=5                " lines to scroll when cursor leaves screen
set scrolloff=3                 " minimum lines to keep above and below cursor
set list

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
au BufRead,BufNewFile *.json set filetype=json " Read json files as JS so syntastic can autolint it

set notimeout      " timeout on mappings and key bindings"
set ttimeout       " timeout on mappings"
set timeoutlen=50

let mapleader = ','

" search buffer for word under cursor
nmap // viwy/<c-r>"<cr>" 

" Easier moving in tabs and windows
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_

" Wrapped lines goes down/up to next row, rather than next line in file.
nnoremap j gj
nnoremap k gk

" http://vim.wikia.com/wiki/Mac_OS_X_clipboard_sharing
nmap <F1> :set paste<CR>
nmap <F2> :set nopaste<CR>

" Replace all occurrences of word under cursor
:nnoremap <leader>r :%s/\<<C-r><C-w>\>/

" Quickly turn a string back to = into an array
nmap <silent> <leader>ta vF=l<Esc>:s/\%V\S\+/"&",/g<CR>A<BS><Esc>vF=2lgS[JJ:let @/ = ""<CR>

" Break comma delimited strings to newline at cursor
nmap <silent> <leader>br :s/, /\=",\r " . substitute(substitute(getline('.'), " :.*$", "", "g"), ".", " ", "g")/g<CR>

" clearing highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

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

let b:match_ignorecase = 1

" Tabularize
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

" Fugitive
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>

" <TAB>: completion.
inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

" Make splits a bit more manageable.
nnoremap <leader>1 :vs<CR><C-w>l
nnoremap <leader>2 :split<CR><C-w>j
nnoremap <C-Up> :bn<CR>
nnoremap <C-Down> :bp<CR>

vmap <Left> <gv
vmap <Right> >gv

let g:rubycomplete_buffer_loading = 1
let g:vimrubocop_config = '~/.rubocop.yml'

let g:syntastic_ignore_files=['\.html$', '\c\.h$', '\.css$']
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#fnamecollapse=1
set laststatus=2

let g:spec_runner_dispatcher = 'Dispatch {command}'
map <Leader>t <plug>RunCurrentSpecFile
map <Leader>s <plug>RunFocusedSpec
map <Leader>l <plug>RunMostRecentSpec

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

" Ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_reuse_window='startify'
let g:ctrlp_extensions=['funky']
if executable('ag')
  let g:ctrlp_user_command='ag %s -l --nocolor -g ""'
endif
let g:ctrlp_switch_buffer=0
let g:ctrlp_working_path=0

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.map
set wildignore+=*/doc/*,*/public/assets/*

let g:unite_data_directory='~/.vim/.cache/unite'
let g:unite_enable_start_insert=1
let g:unite_source_history_yank_enable=1
let g:unite_source_file_rec_max_cache_files=5000
let g:unite_prompt='» '

set grepprg=git\ grep\ -n\ $*

if executable('ag')
  set grepprg=ag\ --nogroup\ --column\ --smart-case\ --nocolor\ --follow
  set grepformat=%f:%l:%c:%m
  let g:unite_source_grep_command='ag'
  let g:unite_source_grep_default_opts='--nocolor --nogroup --hidden'
  let g:unite_source_grep_recursive_opt=''
endif

" Ack.vim like searching
let g:agprg="/usr/local/bin/ag --column --nogroup --nocolor"

if &term =~ '^256color'
  " http://snk.tuxfamily.org/log/vim-256color-bce.html
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif

" And finally. Make it pretty.
set ttyfast
set t_Co=256
let base16colorspace=256
set background=dark
colorscheme base16-eighties

set guifont=Inconsolata-gz\ for\ Powerline:h12

hi clear SpellBad
hi clear SpellRare
hi SpellBad cterm=underline
let g:spellfile_URL = 'http://ftp.vim.org/vim/runtime/spell'
