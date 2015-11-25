" Custom
set directory=.,$TEMP                   " Gets rid of first error
set number                              " Delicious numbers
set autochdir                           " Automatically cd into the directory that the file is in
set showcmd                             " This shows what you are typing as a command.
set shiftwidth=4                        " Statistically twice as much fun as 2
set softtabstop=4
set autoindent smartindent              " Lazy :|
set expandtab                           " Spaces are pretty imbalanced
set smarttab
set backspace=2                         " Just like notepad now
set cul                                 " Current line highlighting
set showmatch                           " Show matching brackets
set ignorecase                          " Searching made easy
set smartcase
set incsearch
set undolevels=1000                     " Mistakes happen, hundreds of them in fact
set mouse=a                             " Mice are pretty good, sometimes
set wildmenu                            " Remembering file paths is really difficult
set wildmode=list:longest,full
set foldmethod=marker                   " Folds modular code
set hlsearch                            " Highlight search matches
set nohidden                            " Flush buffer on close tab
set nobackup                            " don't do backups on different computers
set display=lastline                    " for super long lines
set wrap                                " wrap visually, not the acutal text in buffer
set textwidth=0                         " don't auto wrap lines
set wrapmargin=0
let g:leave_my_textwidth_alone=1        " Make sure BufReads don't change textwidth

map j gj
map k gk

" Long commands
" Spellcheck in english, off by default
if version >= 700
    set spl=en spell
    set nospell
endif
