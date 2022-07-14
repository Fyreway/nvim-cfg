" ----- Plugins -----
call plug#begin()

" Git
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

" File explorer
Plug 'kyazdani42/nvim-tree.lua'

" Statusline/tabline
Plug 'nvim-lualine/lualine.nvim'
Plug 'kdheepak/tabline.nvim'

" Theme/appearance
Plug 'sainnhe/sonokai'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'kyazdani42/nvim-web-devicons'

" Editing
Plug 'vim-scripts/autoclose'
Plug 'tpope/vim-surround'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-repeat'
Plug 'elzr/vim-json'
Plug 'rhysd/vim-clang-format'
Plug 'lukas-reineke/indent-blankline.nvim'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Filetype
Plug 'cdelledonne/vim-cmake'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

call plug#end()

" ----- General settings -----
set confirm

" ----- Window settings -----
" Split below and right
set splitbelow
set splitright

" ----- Keybinding settings -----
nnoremap <Space> <Nop>
nnoremap <Backspace> <Nop>
nnoremap <Return> <Nop>
let g:mapleader = ' '

nnoremap <Leader>nt :NvimTreeToggle<Return>
nnoremap <Leader>h :vert<Space>help<Space>

" ----- Appearance settings -----
syntax on
colorscheme sonokai
set background=dark

lua << END

require('nvim-treesitter.configs').setup {
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}

END

set guifont=Hack:h11

set cursorline

" ----- Gutter settings -----
set number
set signcolumn=yes

lua << END

require('gitsigns').setup {
    signs = {
        delete = {hl = 'GitSignsDelete', text = '>', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn'},
        topdelete = {hl = 'GitSignsDelete', text = '>', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn'},
        changedelete = {hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn'}
    }
}

END

" ----- Tabline and statusline settings -----
" The indicator in lualine renders the default mode indicator useless
set noshowmode

set guioptions-=e
set sessionoptions+=tabpages,globals

" More space for command-line
set cmdheight=3

lua << END
require('lualine').setup {
    options = {
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        globalstatus = true
    },
    sections = {
        lualine_a = {
        { 'mode', fmt = function(str) return str:sub(1,1) end } },
        lualine_b = {'branch', 'diff', { 'diagnostics',
            sources = { 'coc' },
            colored = true,
            update_in_insert = true,
            always_visible = true
        }},
        lualine_c = {
            { 'filename',
                path = 1,
                symbols = {
                    modified = ' ●',
                    readonly = ' '
                }
            }
        },
        lualine_x = {},
        lualine_y = {'filetype'}
    },
    extensions = {'fugitive', 'nvim-tree'}
}
require('tabline').setup {
    enable = true,
    options = {
        max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
        show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
        show_devicons = true, -- this shows devicons in buffer section
        show_bufnr = false, -- this appends [bufnr] to buffer section,
        modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
    }
}
END

" ----- Nvim Tree settings -----
lua << END

require("nvim-tree").setup({
    sort_by = "case_sensitive",
    view = {
        adaptive_size = true,
        mappings = {
            list = {
                { key = "u", action = "dir_up" },
            },
        },
    },
    renderer = {
        group_empty = true,
    },
    filters = {
        dotfiles = true,
    },
})

END

" ----- Completion settings -----
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
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

    " Enable folding
    set foldmethod=indent

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
endfunction

function! s:make_config()
    " Makefiles do not work with space tabs
    set noexpandtab
endfunction

function!  s:c_cpp_config()
    " Set C indent option
    set cindent

    " Set clang-format options
    let g:clang_format#detect_style_file = 1
    let g:clang_format#auto_format = 1
    let g:clang_format#auto_filetypes = ['c', 'cpp', 'objc']
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
