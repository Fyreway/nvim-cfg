-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Allow mouse interaction
vim.opt.mouse = "a"

-- Allow backspace to delete everything
vim.opt.backspace = {"indent", "eol", "start"}

vim.opt.colorcolumn = "120"
vim.opt.textwidth = 119

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Indenting
vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.smartindent = true

vim.api.nvim_create_autocmd(
    {"BufWritePre"},
    {
        pattern = {"*"},
        callback = function()
            vim.cmd "Neoformat"
        end
    }
)
