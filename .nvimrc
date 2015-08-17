let mapleader=","

set encoding=utf-8
scriptencoding utf-8
set showmatch
set showmode
set relativenumber
set number
set textwidth=0
set expandtab
set tabstop=2
set shiftwidth=2
set noerrorbells
set esckeys
set linespace=0
set nojoinspaces
set history=100              " Store a ton of history (default is 20)
set hidden                   " allow buffer switching without saving
set nowrap
set colorcolumn=80
set cursorline               " highlight current line
set autoindent               " indent at the same level of the previous line

" Setting up the directories
set backup                   " backups are nice ...
if has('persistent_undo')
  set undofile               "so is persistent undo ...
  set undolevels=500         "maximum number of changes that can be undone
  set undoreload=500         "maximum number lines to save for undo on a buffer reload
endif

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
set listchars=tab:``,trail:`,extends:#,nbsp:` " Highlight problematic whitespace"
set list                " Show problematic characters.
set hlsearch            " Highlight search results.
set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters.
set incsearch           " Incremental search.
set gdefault            " Use 'g' flag by default with :s/foo/bar/.
set magic               " Use 'magic' patterns (extended regular expressions).

" Also highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/

call plug#begin('~/.nvim/plugged')
  Plug 'scrooloose/nerdtree'
  Plug 'chriskempson/base16-vim'
  Plug 'kien/ctrlp.vim'
  Plug 'bling/vim-airline'
  Plug 'Lokaltog/vim-easymotion'
  Plug 'tpope/vim-surround'
  Plug 'Raimondi/delimitMate'
  Plug 'tpope/vim-fugitive'
  Plug 'AndrewRadev/splitjoin.vim'
  Plug 'scrooloose/nerdcommenter'
  Plug 'tpope/vim-rake'
  Plug 'tpope/vim-projectionist'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-endwise'
  Plug 'thoughtbot/vim-rspec'
  Plug 'gabebw/vim-spec-runner'
  Plug 'christoomey/vim-tmux-runner'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'ngmy/vim-rubocop'
  Plug 'rking/ag.vim'
  Plug 'kchmck/vim-coffee-script'
  Plug 'jade.vim'
  Plug 'scrooloose/syntastic'
  Plug 'FelikZ/ctrlp-py-matcher'
  Plug 'inside/vim-grep-operator'
  Plug 'mattn/emmet-vim'
  Plug 'elixir-lang/vim-elixir'
  Plug 'kana/vim-textobj-user'
  Plug 'nelstrom/vim-textobj-rubyblock'
call plug#end()

" search buffer for word under cursor
nmap // viwy/<c-r>"<cr>" <F37>

" clearing highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

" Easier moving in tabs and windows
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_

" Replace all occurrences of word under cursor
nnoremap <Leader>r :%s/\<<C-r><C-w>\>/
" Break comma delimited strings to newline at cursor
nmap <silent> <Leader>br :s/, /\=",\r " . substitute(substitute(getline('.'), " :.*$", "", "g"), ".", " ", "g")/g<CR>"

" Make splits a bit more manageable.
nnoremap <Leader>1 :vs<CR><C-w>l
nnoremap <Leader>2 :split<CR><C-w>j
nnoremap <C-Up> :bn<CR>
nnoremap <C-Down> :bp<CR>

" visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Adjust viewports to the same size
map <Leader>= <C-w>=

let g:vimrubocop_config = '~/.rubocop.yml'

let g:syntastic_ignore_files=['\.html$', '\c\.h$', '\.css$']
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#fnamecollapse=1
set laststatus=2

let g:spec_runner_dispatcher = 'call VtrSendCommand("be {command}")'
let g:VtrClearSequence = "clear"
map <leader>t <plug>RunCurrentSpecFile
map <leader>s <plug>RunFocusedSpec
map <leader>l <plug>RunMostRecentSpec

" VtrRunner
nmap <leader>p :VtrKillRunner<CR>
nmap <leader>o :VtrOpenRunner({'orientation': 'h', 'percentage': 30})<CR>

set grepprg=git\ grep\ -n\ $*
let g:grep_operator = 'Ag'

nmap <Leader>g <Plug>GrepOperatorOnCurrentDirectory
vmap <Leader>g <Plug>GrepOperatorOnCurrentDirectory
nmap <Leader><Leader>g <Plug>GrepOperatorWithFilenamePrompt
vmap <Leader><Leader>g <Plug>GrepOperatorWithFilenamePrompt

" Fugitive
nnoremap <silent> <leader>gs :Gstatus<CR>
nnoremap <silent> <leader>gd :Gdiff<CR>
nnoremap <silent> <leader>gc :Gcommit<CR>
nnoremap <silent> <leader>gb :Gblame<CR>
nnoremap <silent> <leader>gl :Glog<CR>
nnoremap <silent> <leader>gp :Git push<CR>


" Open file menu
nnoremap <Leader>m :CtrlP<CR>
" Open buffer menu
nnoremap <Leader>b :CtrlPBuffer<CR>
" Open most recently used files
nnoremap <Leader>f :CtrlPMRUFiles<CR>

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

let g:netrw_liststyle=3

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.map
set wildignore+=*/doc/*,*/public/assets/*

function! InitializeDirectories()
  let separator = "."
  let parent = $HOME
  let prefix = '.nvim'
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

map <C-e> :NERDTreeToggle<CR>

let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.map
set wildignore+=*/doc/*,*/public/assets/*
let g:airline#extensions#tabline#enabled = 1

"let base16colorspace=256  " Access colors present in 256 colorspace
set background=dark
colorscheme base16-atelierlakeside
set guifont=Fira\ Code\ for\ Powerline:h12

set spell
set spelllang=en_us

hi SpellBad    guisp=#FF0000 gui=undercurl
hi SpellCap    guisp=#7070F0 gui=undercurl
hi SpellLocal  guisp=#70F0F0 gui=undercurl
hi SpellRare   guisp=#FFFFFF gui=undercurl
