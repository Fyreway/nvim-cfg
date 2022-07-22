local function check_back_space()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    return col == 0 or vim.api.nvim_get_current_line():sub(col, col):match('%s')
end

local function t(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

function _G.tabmap()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif check_back_space() then
        return t "<Tab>"
    else
        vim.fn["coc#refresh"]()
    end
end

function _G.stabmap()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    else
        vim.fn["coc#refresh"]()
    end
end

vim.keymap.set('i', '<Tab>', 'v:lua.tabmap()', { expr = true })
vim.keymap.set('i', '<S-Tab>', 'v:lua.stabmap()', { expr = true })
