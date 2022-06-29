" ----- Plugins -----
call plug#begin()

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" NERDTree
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Theme
Plug 'sainnhe/sonokai'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'bounceme/poppy.vim'

" Editing
Plug 'tpope/vim-surround'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-repeat'
Plug 'elzr/vim-json'
Plug 'rhysd/vim-clang-format'

" Completion
Plug 'ycm-core/YouCompleteMe'

" Filetype
Plug 'r-bar/ebnf.vim'
Plug 'vim-scripts/c.vim'
Plug 'bfrg/vim-cpp-modern'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

call plug#end()

" ----- General settings -----
se cf

" ----- Window settings -----
" Split below and right
se sb spr

" ----- Keybinding settings -----
nnoremap <Space> <Nop>
nnoremap <Backspace> <Nop>
nnoremap <Return> <Nop>
let g:mapleader = ' '

nnoremap <Leader>nt :NERDTreeToggle<Return>
nnoremap <Leader>h :vert<Space>help<Space>

" ----- Appearance settings -----
syn on
colo sonokai
se bg=dark

se cul

" ----- Gutter settings -----
se nu

" ----- Tabline and statusline settings -----
" The indicator in airline renders the default mode indicator useless
se nosmd

" More space for command-line
se ch=3

" Enable fancy Powerline symbols (arrows)
let g:airline_powerline_fonts = 1

" Enable enhanced tabline
let g:airline#extensions#tabline#enabled = 1

" Use short forms of modes
let g:airline_mode_map = {
      \ '__'     : '-',
      \ 'c'      : 'C',
      \ 'i'      : 'I',
      \ 'ic'     : 'I',
      \ 'ix'     : 'I',
      \ 'n'      : 'N',
      \ 'multi'  : 'M',
      \ 'ni'     : 'N',
      \ 'no'     : 'N',
      \ 'R'      : 'R',
      \ 'Rv'     : 'R',
      \ 's'      : 'S',
      \ 'S'      : 'S',
      \ ''     : 'S',
      \ 't'      : 'T',
      \ 'v'      : 'V',
      \ 'V'      : 'V',
      \ ''     : 'V',
      \ }

" Skip empty sections in statusbar -- no use showing them
let g:airline_skip_empty_sections = 1

" ----- NERDTree settings -----
" Start NERDTree when Vim is started without file arguments.
au StdinReadPre * let s:std_in=1
au VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | en

" Exit Vim if NERDTree is the only window remaining in the only tab.
au BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree')
    \ && b:NERDTree.isTabTree() | q | en

" Close the tab if NERDTree is the only window remaining in it.
au BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | q | en

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
au BufEnter * if bufname('"') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | b" | exe 'normal! \<C-W>w' | exe 'buffer'.buf | en

let g:NERDTreeHighlightFolders = 1

" ----- Editing settings -----
" Always use UTF-8
se enc=UTF-8

" Allow mouse interaction
se mouse=a

" Powerful backspace
se bs=indent,eol,start

" OS Clipboard
se cb=unnamed

" Line limit
se cc=120 wm=120 tw=119

" Indenting
se et sw=4 sts=4 ts=4 ai sta si

fu s:python_config()
    " Set PEP 8 line limit at 80 characters
    se cc=80 wm=80 tw=79

    " Enable folding
    se fdm=indent

    " Configure pymode
    let g:pymode = 1
    let g:pymode_warnings = 1
    let g:pymode_trim_whitespaces = 1
    let g:pymode_options = 1
    let g:pymode_python = 'python3'
    let g:pymode_indent = 1
    let g:pymode_doc = 1
    let g:pymode_doc_bind = 'K'
    let g:pymode_virtualenv = 1
    let g:pymode_run = 0
    let g:pymode_breakpoint = 0
    let g:pymode_lint = 1
    let g:pymode_lint_on_write = 1
    let g:pymode_lint_unmodified = 1
    let g:pymode_lint_on_fly = 1
    let g:pymode_lint_message = 1
    let g:pymode_lint_checkers = ['pylint', 'pep8']
    let g:pymode_lint_cwindow = 1
    let g:pymode_lint_signs = 1
    let g:pymode_lint_todo_symbol = 'W '
    let g:pymode_lint_comment_symbol = 'C '
    let g:pymode_lint_visual_symbol = 'R '
    let g:pymode_lint_error_symbol = 'E '
    let g:pymode_lint_info_symbol = 'I '
    let g:pymode_lint_pyflakes_symbol = 'F '
    let g:pymode_rope = 1
    let g:pymode_rope_show_doc_bind = '<C-c>d'
    let g:pymode_rope_regenerate_on_write = 1
    set completeopt=menuone,noinsert
    let g:pymode_rope_completion = 1
    let g:pymode_rope_complete_on_dot = 1
    let g:pymode_rope_completion_bind = '<C-Space>'
    let g:pymode_rope_autoimport = 0
endf

fu s:make_config()
    " Makefiles do not work with space tabs
    se noet
endf

fu  s:c_cpp_config()
    " Set C indent option
    se cin

    " Set clang-format options
    let g:clang_format#detect_style_file = 1
    let g:clang_format#auto_format = 1
    let g:clang_format#auto_filetypes = ['c', 'cpp', 'objc']
endf

fu s:c_config()
    call s:c_cpp_config()

    " Enable folding
    se fdm=syntax
endf

fu s:cpp_config()
    call s:c_cpp_config()
endf

aug filetype_config
    au BufRead,BufNewFile *.py call s:python_config()
    au BufRead,BufNewFile Makefile* call s:make_config()
    au BufRead,BufNewFile *.c,*.h call s:c_config()
    au BufRead,BufNewFile *.cpp,*.cc,*.cxx,*.c++,*.C,
                         \*.hpp,*.hh,*.hxx,*.h++,*.H call s:cpp_config()
aug END
