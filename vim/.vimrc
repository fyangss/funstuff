" Completely stolen vimrc {

" Environment {

" Identify platform {
silent function! OSX()
return has('macunix')
  endfunction
  silent function! LINUX()
  return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
return (has('win32') || has('win64'))
  endfunction
  " }

  " Pre-reqs {
  set nocompatible      " Must be first line
  if !WINDOWS()
    set shell=/bin/sh
  endif
  " }

  " Windows Compatible {
  " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
  " across (heterogeneous) systems easier.
  if WINDOWS()
    set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
  endif
  " }

  " Arrow Key Fix {
  if &term[:4] == "xterm" || &term[:5] == 'screen' || &term[:3] == 'rxvt'
    inoremap <silent> <C-[>OC <RIGHT>
  endif
  " }

  " }

  " Other configs {

  "Use before config if available {
  if filereadable(expand("~/.vimrc.before"))
    source ~/.vimrc.before
  endif
  " }

  " Use bundles config {
  if filereadable(expand("~/.vimrc.bundles"))
    source ~/.vimrc.bundles
  endif
  " }

  " }

  " General {
  set background=light       " background triggering logic based off light background

  if !has('gui')
    set term=$TERM      " Make arrow and other keys work
  endif
  filetype plugin indent on   " Automatically detect file types.
  syntax on           " Syntax highlighting
  set mouse=a         " Automatically enable mouse usage
  set mousehide         " Hide the mouse cursor while typing
  scriptencoding utf-8

  if has('clipboard')
    if has('unnamedplus')
      set clipboard^=unnamed,unnamedplus " ^= prepends
    else
      set clipboard^=unnamed
    endif
  endif

  " Most prefer to automatically switch to the current file directory when
  " a new buffer is opened; to prevent this behavior, add the
  " following to let g:fy_no_autochdir = 1
  if !exists('g:fy_no_autochdir')
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
    " Always switch to the current file directory
  endif

  set autowrite             " Automatically write a file when leaving a modified buffer
  set shortmess+=filmnrxoOtT      " Abbrev. of messages (avoids 'hit enter')
  set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
  set virtualedit=onemore       " Allow for cursor beyond last character
  set history=100           " Store a ton of history (default is 20)
  set spell               " Spell checking on
  set hidden              " Allow buffer switching without saving

  " Keywords
  " Sets symbols as end of word designators
  set iskeyword-=.
  set iskeyword-=#
  set iskeyword-=-
  set iskeyword-=_

  " Instead of reverting the cursor to the last position in the buffer, we
  " set it to the first line when editing a git commit message
  au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

  " http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
  " Restore cursor to file position in previous editing session
  " To disable this, add the following to your .vimrc.before.local
  " file: let g:fy_no_restore_cursor = 1
  if !exists('g:fy_no_restore_cursor')
    function! ResCur()
      if line("'\"") <= line("$")
        silent! normal! g`"
        return 1
      endif
    endfunction

    augroup resCur
      autocmd!
      autocmd BufWinEnter * call ResCur()
    augroup END
  endif

  " Setting up the directories {
  set backup          " Backups are nice ...
  if has('persistent_undo')
    set undofile        " So is persistent undo ...
    set undolevels=100      " Maximum number of changes that can be undone
    set undoreload=1000     " Maximum number lines to save for undo on a buffer reload
  endif

  " To disable views add the following to your .vimrc.before.local file:
  " let g:fy_no_views = 1
  if !exists('g:fy_no_views')
    " Add exclusions to mkview and loadview
    " eg: *.*, svn-commit.tmp
    let g:skipview_files = [
          \ '\[example pattern\]'
          \ ]
  endif
  " }
  " }

  " Vim UI{

  " Colorscheme {
  set termguicolors   " enable true colors support
  colorscheme lucius
  " }

  set tabpagemax=15         " Only show 15 tabs
  set showmode          " Display the current mode

"  set cursorline        " Highlight current line
  set nocul             " Looks terrible on OSX

  highlight clear SignColumn    " SignColumn should match background
  highlight clear LineNr      " Current line number row will have same background color in relative mode
  "highlight clear CursorLineNr  " Remove highlight color from current line number

  if has('cmdline_info')
    set ruler           " Show the ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
    set showcmd         " Show partial commands in status line and
    " Selected characters/lines in visual mode
  endif

  if has('statusline')
    set laststatus=2

    " Broken down into easily includeable segments
    set statusline=%<%f\           " Filename
    set statusline+=%w%h%m%r         " Options
    "if !exists('g:override_fy_bundles')
    "set statusline+=%{fugitive#statusline()} " Git Hotness
    "endif
    set statusline+=\ [%{&ff}/%Y]      " Filetype
    set statusline+=\ [%{getcwd()}]      " Current dir
    set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
  endif

  set backspace=indent,eol,start  " Backspace for dummies
  set linespace=0         " No extra spaces between rows
  set number            " Line numbers on
  set showmatch           " Show matching brackets/parenthesis
  set incsearch           " Find as you type search
  set hlsearch          " Highlight search terms
  set winminheight=0        " Windows can be 0 line high
  set ignorecase          " Case insensitive search
  set smartcase           " Case sensitive when uc present
  set wildmenu          " Show list instead of just completing
  set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
  set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
  set scrolljump=15       " Lines to scroll when cursor leaves screen
  set scrolloff=3         " Minimum lines to keep above and below cursor
  set list
  set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

  set foldenable          " Auto fold code
  set foldmethod=marker   " Mostly for this doc, syntax for real folding
  set foldmarker={,}
  augroup remember_folds
    autocmd!
    autocmd BufWinLeave * mkview
    autocmd BufWinEnter * silent! loadview
  augroup END

  " }

  " Formatting {

  set wrap                " Wrap long lines
  set textwidth=0
  set wrapmargin=0
  set linebreak           " Only insert breaks when pressing enter
  set autoindent          " Indent at the same level of the previous line
  set expandtab           " Tabs are spaces, not tabs
  set tabstop=2           " An indentation every two columns
  set softtabstop=2       " Let backspace delete indent
  set shiftwidth=2        " Use indents of 2 spaces
  set nojoinspaces        " Prevents inserting two spaces after punctuation on a join (J)
  set splitright          " Puts new vsplit windows to the right of the current
  set splitbelow          " Puts new split windows to the bottom of the current
  set matchpairs+=<:>     " Press % to go to matching brace, adds angle brackets
  set pastetoggle=<F12>       " pastetoggle (sane indentation on pastes)
  set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks

  " Strip whitespace {
    function! StripTrailingWhitespace()
      " Preparation: save last search, and cursor position.
      let _s=@/
      let l = line(".")
      let c = col(".")
      " do the business:
      %s/\s\+$//e
      " clean up: restore previous search history, and cursor position
      let @/=_s
      call cursor(l, c)
    endfunction

    " Remove trailing whitespaces and ^M chars
    " To disable the stripping of whitespace, add the following to your .vimrc.before.local file:
    " let g:fy_keep_trailing_whitespace = 1
    "autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,sql autocmd BufWritePre <buffer> if !exists('g:fy_keep_trailing_whitespace') | call StripTrailingWhitespace() | endif
    if !exists('g:fy_keep_trailing_whitespace')
      call StripTrailingWhitespace()
    endif
  " }

  autocmd FileType go autocmd BufWritePre <buffer> Fmt
  autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
  autocmd FileType haskell,puppet,ruby,yml setlocal expandtab shiftwidth=2 softtabstop=2
  autocmd BufNewFile,BufRead *.coffee set filetype=coffee

  " Workaround vim-commentary for Haskell
  autocmd FileType haskell setlocal commentstring=--\ %s
  " Workaround broken colour highlighting in Haskell
  autocmd FileType haskell,rust setlocal nospell

  " }

  " Plugins {
    " Fuzzy searching
    set rtp+=~/.fzf

    " Initiate on launch
    autocmd VimEnter * NERDTree | wincmd p

    " Close vim if NERDTree is the last buffer
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
  " }

  " Key (re)Mappings {

  " Easier to reach
  let mapleader= ","

  " Wrapped lines goes down/up to next row, rather than next line in file.
  noremap j gj
  noremap k gk

  " Split movement
  nnoremap <C-J> <C-W><C-J>
  nnoremap <C-K> <C-W><C-K>
  nnoremap <C-L> <C-W><C-L>
  nnoremap <C-H> <C-W><C-H>

  " Copying
  map <C-Y> :%y+
  " Yank from the cursor to the end of the line, to be consistent with C and D.
  nnoremap Y y$

  " Code folding options
  nmap <leader>f0 :set foldlevel=0<CR>
  nmap <leader>f1 :set foldlevel=1<CR>
  nmap <leader>f2 :set foldlevel=2<CR>
  nmap <leader>f3 :set foldlevel=3<CR>
  nmap <leader>f4 :set foldlevel=4<CR>
  nmap <leader>f5 :set foldlevel=5<CR>
  nmap <leader>f6 :set foldlevel=6<CR>
  nmap <leader>f7 :set foldlevel=7<CR>
  nmap <leader>f8 :set foldlevel=8<CR>
  nmap <leader>f9 :set foldlevel=9<CR>

  " Shortcuts
  " Change Working Directory to that of the current file
  cmap cwd lcd %:p:h
  cmap cd. lcd %:p:h

  " Find merge conflict markers
  map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

  " Visual shifting (does not exit Visual mode)
  vnoremap < <gv
  vnoremap > >gv

  " Allow using the repeat operator with a visual selection (!)
  " http://stackoverflow.com/a/8064607/127816
  vnoremap . :normal .<CR>

  " For when you forget to sudo.. Really Write the file.
  cmap w!! w !sudo tee % >/dev/null

  " Map <Leader>ff to display all lines with keyword under cursor
  " and ask which one to jump to
  nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

  " Easier horizontal scrolling
  map zl zL
  map zh zH

  " }

  " GUI Settings {

  " GVIM- (here instead of .gvimrc)
  if has('gui_running')
    set guioptions-=T       " Remove the toolbar
    set lines=40        " 40 lines of text instead of 24
    if !exists("g:fy_no_big_font")
      if LINUX() && has("gui_running")
        set guifont=Andale\ Mono\ Regular\ 12,Menlo\ Regular\ 11,Consolas\ Regular\ 12,Courier\ New\ Regular\ 14
      elseif OSX() && has("gui_running")
        set guifont=Andale\ Mono\ Regular:h12,Menlo\ Regular:h11,Consolas\ Regular:h12,Courier\ New\ Regular:h14
      elseif WINDOWS() && has("gui_running")
        set guifont=Andale_Mono:h10,Menlo:h10,Consolas:h10,Courier_New:h10
      endif
    endif
  else
    if &term == 'xterm' || &term == 'screen'
      set t_Co=256      " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
    endif
    "set term=builtin_ansi     " Make arrow and other keys work
  endif

  " }

  " Functions {

  " Initialize directories {
  function! InitializeDirectories()
    let parent = $HOME
    let prefix = 'vim'
    let dir_list = {
          \ 'backup': 'backupdir',
          \ 'views': 'viewdir',
          \ 'swap': 'directory' }

    if has('persistent_undo')
      let dir_list['undo'] = 'undodir'
    endif

    " To specify a different directory in which to place the vimbackup,
    " vimviews, vimundo, and vimswap files/directories, add the following to
    " your .vimrc.before.local file:
    "   let g:fy_consolidated_directory = <full path to desired directory>
    "   eg: let g:fy_consolidated_directory = $HOME . '/.vim/'
    if exists('g:fy_consolidated_directory')
      let common_dir = g:fy_consolidated_directory . prefix
    else
      let common_dir = parent . '/.' . prefix
    endif

    for [dirname, settingname] in items(dir_list)
      let directory = common_dir . dirname . '/' " Default example $HOME/.vimbackup/
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
  " }

  " End/Start of line motion keys act relative to row/wrap width in the
  " presence of `:set wrap`, and relative to line for `:set nowrap`.
  " Default vim behaviour is to act relative to text line in both cases
  " If you prefer the default behaviour, add the following to your
  " .vimrc.before.local file:
  "   let g:fy_no_wrapRelMotion = 1
  if !exists('g:fy_no_wrapRelMotion')
    " Same for 0, home, end, etc
    function! WrapRelativeMotion(key, ...)
      let vis_sel=""
      if a:0
        let vis_sel="gv"
      endif
      if &wrap
        execute "normal!" vis_sel . "g" . a:key
      else
        execute "normal!" vis_sel . a:key
      endif
    endfunction
  endif

  " }

  " Other vim localized versions and cleanup {

  " Use fork vimrc if available {
  if filereadable(expand("~/.vimrc.fork"))
    source ~/.vimrc.fork
  endif
  " }

  " Use local vimrc if available {
  if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
  endif
  " }

  " Use local gvimrc if available and gui is running {
  if has('gui_running')
    if filereadable(expand("~/.gvimrc.local"))
      source ~/.gvimrc.local
    endif
  endif
  " }

  " }

" }
