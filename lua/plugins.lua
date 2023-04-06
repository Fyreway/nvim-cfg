-- Bootstrap packer for newly cloned configs
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    Packer_bootstrap =
        vim.fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
    vim.cmd "packadd packer.nvim"
else
    require("impatient")
end

return require("packer").startup(
    function(use)
        use "wbthomason/packer.nvim"

        use {
            "olimorris/onedarkpro.nvim",
            branch = "main",
            config = function()
                vim.cmd "colo onedark"
            end
        }

        -- Git
        use "tpope/vim-fugitive"

        use "airblade/vim-gitgutter"

        -- Lualine
        use {
            "nvim-lualine/lualine.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            after = {
                "vim-fugitive",
                "nvim-lspconfig"
            },
            config = function()
                require("lualine").setup {
                    sections = {
                        lualine_a = {
                            {
                                "mode",
                                fmt = function(str)
                                    return str:sub(1, 1)
                                end
                            }
                        },
                        lualine_b = {
                            "branch",
                            "diff",
                            {
                                "diagnostics",
                                sources = {"nvim_lsp"},
                                colored = true,
                                update_in_insert = true,
                                always_visible = true
                            }
                        },
                        lualine_c = {{"filename", path = 1, symbols = {modified = " ●", readonly = " "}}},
                        lualine_x = {},
                        lualine_y = {"filetype"}
                    },
                    extensions = {"fugitive"}
                }

                if _G.Statusline_timer == nil then
                    _G.Statusline_timer = vim.loop.new_timer()
                else
                    _G.Statusline_timer:stop()
                end

                _G.Statusline_timer:start(
                    0,
                    1000,
                    vim.schedule_wrap(
                        function()
                            vim.cmd "redrawtabline"
                        end
                    )
                )
            end
        }

        -- Bufferline
        use {
            "akinsho/bufferline.nvim",
            requires = "kyazdani42/nvim-web-devicons",
            config = function()
                require("bufferline").setup {}
            end
        }

        -- Syntax highlighting
        use {
            "nvim-treesitter/nvim-treesitter",
            config = function()
                require("nvim-treesitter.configs").setup {
                    ensure_installed = {
                        "lua",
                        "rust",
                        "python",
                        "vim",
                        "json",
                        "jsonc",
                        "toml"
                    },
                    highlight = {enable = true, additional_vim_regex_highlighting = false}
                }
            end
        }

        use {
            "m-demare/hlargs.nvim",
            requires = "nvim-treesitter/nvim-treesitter",
            config = function()
                require("hlargs").setup {}
            end
        }

        -- Autoclosing brackets
        use {
            "windwp/nvim-autopairs",
            config = function()
                require("nvim-autopairs").setup {}
            end
        }

        -- Bracket operations
        use {
            "kylechui/nvim-surround",
            config = function()
                require("nvim-surround").setup {}
            end
        }

        -- Comment operations
        use "tpope/vim-commentary"

        -- More powerful '.'
        use "tpope/vim-repeat"

        -- Insert 'end'
        use "tpope/vim-endwise"

        -- Better JSON
        use "elzr/vim-json"

        -- Formatting
        use "sbdchd/neoformat"

        -- Indent guides
        use {
            "lukas-reineke/indent-blankline.nvim",
            config = function()
                require("indent_blankline").setup {filetype_exclude = {"dashboard"}}
            end
        }

        -- Look up anything
        use {
            "nvim-telescope/telescope.nvim",
            requires = "nvim-lua/plenary.nvim"
        }

        use {
            "nvim-telescope/telescope-file-browser.nvim",
            after = "telescope.nvim",
            config = function()
                require("telescope").load_extension "file_browser"
            end
        }

        use {
            "neovim/nvim-lspconfig",
            config = function()
                local lspconfig = require("lspconfig")
                lspconfig.lua_ls.setup {
                    settings = {
                        Lua = {
                            runtime = {
                                version = "LuaJIT"
                            },
                            diagnostics = {
                                globals = {"vim"}
                            },
                            workspace = {
                                library = vim.api.nvim_get_runtime_file("", true)
                            },
                            telemetry = {
                                enable = false
                            }
                        }
                    }
                }
                lspconfig.vimls.setup {}
                lspconfig.clangd.setup {}
                lspconfig.cmake.setup {}
                lspconfig.rust_analyzer.setup {}
            end
        }

        use {
            "ms-jpq/coq_nvim",
            after = "nvim-lspconfig",
            requires = {
                "ms-jpq/coq.artifacts",
                "ms-jpq/coq.thirdparty"
            },
            run = ":COQdeps",
            config = function()
                require("coq").Now()
            end
        }

        use {
            "simrat39/rust-tools.nvim",
            after = "nvim-lspconfig",
            config = function()
                require("rust-tools").setup {}
            end
        }

        use {
            "p00f/clangd_extensions.nvim",
            after = "nvim-lspconfig",
            config = function()
                require("clangd_extensions").setup {}
            end
        }

        -- Speed up loading times
        use "lewis6991/impatient.nvim"

        use "jghauser/mkdir.nvim"

        use {
            "goolord/alpha-nvim",
            config = function()
                require("alpha").setup(require("alpha.themes.dashboard").config)
            end
        }

        use {
            "sudormrfbin/cheatsheet.nvim",
            requires = {
                "nvim-telescope/telescope.nvim",
                "nvim-lua/popup.nvim",
                "nvim-lua/plenary.nvim"
            }
        }

        if Packer_bootstrap then
            require("packer").sync()
        end
    end
)
