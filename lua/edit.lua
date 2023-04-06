-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Allow mouse interaction
vim.opt.mouse = "a"

-- Allow backspace to delete everything
vim.opt.backspace = {"indent", "eol", "start"}

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

vim.api.nvim_create_autocmd(
    {"BufWritePre"},
    {
        pattern = {"*"},
        callback = function()
            vim.cmd "Neoformat"
        end
    }
)

vim.api.nvim_create_autocmd(
    {"BufEnter", "BufNewFile"},
    {
        pattern = {"*"},
        callback = function()
            set_linelim(120)
            set_indent(4)
        end
    }
)
