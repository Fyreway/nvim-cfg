-- Keybindings
vim.keymap.set('n', '<Space>', '', { noremap = true })
vim.keymap.set('n', '<Backspace>', '', { noremap = true })
vim.keymap.set('n', '<Return>', '', { noremap = true })
vim.g.mapleader = ' '

-- Help
vim.keymap.set('n', '<Leader>h', ':vert h ', { noremap = true })

-- Create, move between, and delete buffers
vim.keymap.set('n', '<Leader>o', ':e ', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader><Tab>', ':bn<Return>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader><S-Tab>', ':bp<Return>', { noremap = true, silent = true })
vim.keymap.set('n', '<Leader>bq', ':bp<Return>:bd #<Return>', { noremap = true, silent = true })

-- Shift line vertically
vim.keymap.set('i', '<C-Down>', '<Esc>ddpi', { noremap = true })
vim.keymap.set('i', '<C-Up>', '<Esc>ddkkpi', { noremap = true })

-- Duplicate line vertically
vim.keymap.set('i', '<C-S-Down>', '<Esc>yypi', { noremap = true })
vim.keymap.set('i', '<C-S-Up>', '<Esc>yykpi', { noremap = true })
