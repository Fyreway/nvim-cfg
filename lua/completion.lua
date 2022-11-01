local function check_back_space()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    return col == 0 or vim.api.nvim_get_current_line():sub(col, col):match('%s')
end

function _G.tabmap()
    if vim.fn['coc#pum#visible']() == 1 then
        return vim.fn['coc#_select_confirm']()
    elseif check_back_space() then
        return vim.api.nvim_replace_termcodes('<C-g>u<Tab>', true, true, true)
    else
        return vim.fn['coc#refresh']()
    end
end

vim.keymap.set('i', '<Tab>', 'v:lua.tabmap()', { silent = true, expr = true, noremap = true, replace_keycodes = false })
