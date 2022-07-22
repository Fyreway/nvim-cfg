" ----- Plugins -----
lua require("impatient")
lua require("plugins")

" ----- General settings -----
set confirm
let g:loaded_ruby_provider = 0
let g:loaded_perl_provider = 0

" ----- Window settings -----
" Split below and right
set splitbelow
set splitright

" ----- Keybinding settings -----
nnoremap <Space> <Nop>
nnoremap <Backspace> <Nop>
nnoremap <Return> <Nop>
let g:mapleader = " "

" Trigger help
nnoremap <Leader>h :vert<Space>help<Space>

" Buffer operations
nnoremap <Leader><Tab> :bn
nnoremap <Leader><S-Tab> :bp
nnoremap <Leader>o :e<Space>
nnoremap <Leader>bq :bp<Return>:bd<Space>#<Return>

" Shift line down/up (useful VSCode shortcut)
inoremap <C-Down> <Esc>ddpi
inoremap <C-Up> <Esc>ddkkpi

" Copy line down/up (useful VSCode shortcut)
inoremap <C-S-Down> <Esc>yypi
inoremap <C-S-Up> <Esc>yykpi

" ----- Appearance settings -----
colorscheme monokai_pro
set termguicolors
set background=dark

set cursorline

" ----- Gutter settings -----
set number
set signcolumn=yes

" ----- Tabline and statusline settings -----
" The indicator in lualine renders the default mode indicator useless
set noshowmode

set guioptions-=e
set sessionoptions+=tabpages,globals

" More space for command-line
set cmdheight=3

" ----- Completion settings -----
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
    let col = col(".") - 1
    return !col || getline(".")[col - 1]  =~ "\s"
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" ----- Editing settings -----
" Folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldlevelstart=99
set foldlevel=99

" Allow mouse interaction
set mouse=a

" Powerful backspace
set backspace=indent,eol,start

" OS Clipboard
set clipboard=unnamed

" Line limit
set colorcolumn=120
set textwidth=119

" Indenting
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set autoindent
set smarttab
set smartindent

function! s:python_config()
    " Set PEP 8 line limit at 80 characters
    set colorcolumn=80
    set textwidth=79
endfunction

function! s:make_config()
    " Makefiles do not work with space tabs
    set noexpandtab
endfunction

function! s:c_cpp_config()
    " Set C indent option
    set cindent

    " Set clang-format options
    let g:clang_format#detect_style_file = 1
    let g:clang_format#auto_format = 1
    let g:clang_format#auto_filetypes = ["c", "cpp", "objc"]

    " C/C++ keybindings
    nnoremap <Leader>gd :CocCommand<Space>clangd.switchSourceHeader<Return>
endfunction

function! s:c_config()
    setfiletype c
    call s:c_cpp_config()

    " Enable folding
    set foldmethod=syntax
endfunction

function! s:cpp_config()
    setfiletype cpp
    call s:c_cpp_config()
endfunction

augroup filetype_config
    autocmd BufRead,BufNewFile *.py call s:python_config()
    autocmd BufRead,BufNewFile Makefile call s:make_config()
    autocmd BufRead,BufNewFile *.c,*.h call s:c_config()
    autocmd BufRead,BufNewFile *.cpp,*.cc,*.cxx,*.c++,*.C,*.hpp,*.hh,*.hxx,*.h++,*.H call s:cpp_config()
augroup END
