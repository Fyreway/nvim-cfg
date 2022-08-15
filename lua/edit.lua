vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = vim.fn['nvim_treesitter#foldexpr']()
vim.opt.foldlevelstart = 99
vim.opt.foldlevel = 99

-- Allow mouse interaction
vim.opt.mouse = 'a'

-- Allow backspace to delete everything
vim.opt.backspace = {'indent', 'eol', 'start'}

local function set_indent(spaces)
    if spaces < 0 then
        vim.opt_local.tabstop = -spaces
        vim.opt_local.softtabstop = -spaces
        vim.opt_local.shiftwidth = -spaces
        vim.opt_local.expandtab = false
    else
        vim.opt_local.tabstop = spaces
        vim.opt_local.softtabstop = spaces
        vim.opt_local.shiftwidth = spaces
        vim.opt_local.expandtab = true
    end
end

local function set_linelim(lim)
    vim.opt_local.colorcolumn = tostring(lim)
    vim.opt_local.textwidth = lim - 1
end

-- Indenting
vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.smartindent = true

local function default_cfg()
    set_linelim(120)
    set_indent(4)
end

local function py_cfg()
    set_linelim(80)
end

local function make_cfg()
    set_indent(-4)
end

local function c_cpp_cfg()
    vim.opt_local.cindent = true

    vim.g['clang_format#detect_style_file'] = 1
    vim.g['clang_format#auto_format'] = 1
    vim.g['clang_format#auto_filetypes'] = {'c', 'cpp'}

    vim.keymap.set('n', '<Leader>gd', ':CocCommand clangd.switchSourceHeader<Return>', {noremap = true, silent = true})
end

local function c_cfg()
    c_cpp_cfg()
end

local function cpp_cfg()
    c_cpp_cfg()
end

vim.filetype.add {extension = {h = 'c'}}


vim.api.nvim_create_autocmd({'BufWritePre'}, {
    pattern = {'*'},
    callback = function() vim.cmd 'Neoformat' end
})


vim.api.nvim_create_autocmd({'BufEnter', 'BufNewFile'}, {
    pattern = {'*'},
    callback = default_cfg
})

vim.api.nvim_create_autocmd({'BufEnter', 'BufNewFile'}, {
    pattern = {'*.py'},
    callback = py_cfg
})

vim.api.nvim_create_autocmd({'BufEnter', 'BufNewFile'}, {
    pattern = {'*.c', '*.h'},
    callback = c_cfg
})

vim.api.nvim_create_autocmd({'BufEnter', 'BufNewFile'}, {
    pattern = {'*.cpp', '*.hpp', '*.cc', '*.hh', '*.C', '*.H'},
    callback = cpp_cfg
})

vim.api.nvim_create_autocmd({'BufEnter', 'BufNewFile'}, {
    pattern = {'Makefile'},
    callback = make_cfg
})
