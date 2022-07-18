local map = vim.api.nvim_set_keymap

local function nnoremap(s, o)
    map('n', s, o, {noremap = true})
end

local function inoremap(s, o)
    map('i', s, o, {noremap = true})
end

return require('packer').startup(function()
    use 'wbthomason/packer.nvim'

    use 'tanvirtin/monokai.nvim'

    -- Git
    use 'tpope/vim-fugitive'
    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup {
                signs = {
                    delete = {
                        hl = 'GitSignsDelete',
                        text = '>',
                        numhl = 'GitSignsDeleteNr',
                        linehl = 'GitSignsDeleteLn'
                    },
                    topdelete = {
                        hl = 'GitSignsDelete',
                        text = '>',
                        numhl = 'GitSignsDeleteNr',
                        linehl = 'GitSignsDeleteLn'
                    },
                    changedelete = {
                        hl = 'GitSignsChange',
                        text = '│',
                        numhl = 'GitSignsChangeNr',
                        linehl = 'GitSignsChangeLn'
                    }
                }
            }
        end
    }

    -- File explorer
    use {
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons', },
        config = function()
            require('nvim-tree').setup {
                sort_by = 'case_sensitive',
                view = {
                    adaptive_size = true,
                },
                renderer = {
                    group_empty = true,
                },
                filters = {
                    dotfiles = true,
                },
            }
            nnoremap('<Leader>nt', ':NvimTreeToggle<Return>')
        end
    }

    -- Lualine
    use {
        'nvim-lualine/lualine.nvim',
        requires = {
            'kyazdani42/nvim-web-devicons',
            'kdheepak/tabline.nvim',
            'tpope/vim-fugitive',
            'kyazdani42/nvim-tree.lua',
        },
        config = function()
            require('lualine').setup {
                options = {
                    component_separators = { left = '', right = '', },
                    section_separators = { left = '', right = '', },
                    globalstatus = true,
                },
                sections = {
                    lualine_a = {
                        {
                            'mode',
                            fmt = function(str) return str:sub(1,1) end
                        }
                    },
                    lualine_b = {
                        'branch',
                        'diff',
                        {
                            'diagnostics',
                            sources = { 'coc', },
                            colored = true,
                            update_in_insert = true,
                            always_visible = true
                        }
                    },
                    lualine_c = {
                        {
                            'filename',
                            path = 1,
                            symbols = {
                                modified = ' ●',
                                readonly = ' '
                            }
                        }
                    },
                    lualine_x = {},
                    lualine_y = { 'filetype', },
                },
                tabline = {
                    lualine_c = { require('tabline').tabline_buffers, },
                    lualine_y = { 'os.date("%I:%M:%S", os.time())', },
                },
                extensions = { 'fugitive', 'nvim-tree', }
            }

            if _G.Statusline_timer == nil then
                _G.Statusline_timer = vim.loop.new_timer()
            else
                _G.Statusline_timer:stop()
            end
            _G.Statusline_timer:start(0, 1000, vim.schedule_wrap(function()
                vim.api.nvim_command('redrawtabline')
            end))
        end
    }

    -- Tabline
    use {
        'kdheepak/tabline.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', },
        config = function()
            require('tabline').setup {
                enable = false,
                options = {
                    max_bufferline_percent = 66,
                    show_tabs_always = false,
                    show_devicons = true,
                    show_bufnr = false,
                    modified_italic = false,
                },
            }
        end
    }

    -- Treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require('nvim-treesitter.configs').setup {
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            }
        end
    }

    -- Autoclosing brackets
    use {
	    'windwp/nvim-autopairs',
        config = function()
            require('nvim-autopairs').setup {}
        end
    }

    -- Bracket operations
    use 'tpope/vim-surround'

    -- Comment operations
    use 'preservim/nerdcommenter'

    -- More powerful '.'
    use 'tpope/vim-repeat'

    -- Better JSON
    use 'elzr/vim-json'

    -- clang-format support
    use 'rhysd/vim-clang-format'

    -- Indent guides
    use 'lukas-reineke/indent-blankline.nvim'

    -- Look up anything
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
    }

    -- CoC
    use {
        'neoclide/coc.nvim',
        branch = 'release',
    }

    -- CMake
    use 'cdelledonne/vim-cmake'

    -- Speed up loading times
    use 'lewis6991/impatient.nvim'
end)
