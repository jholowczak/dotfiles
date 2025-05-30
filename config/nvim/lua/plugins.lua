-- plugins

-- load lazy.nvim from disk, if not grab from git
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  { "folke/lazydev.nvim",
        ft = "lua",
        opts = {
            library = {
                "~/.config/nvim/plugins/nvim-remote-containers"
            },
        },
  },
  {'nvim-treesitter/nvim-treesitter'},
  'neovim/nvim-lspconfig', -- Collection of configurations for the built-in LSP client
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',

  --snippets
  { "L3MON4D3/LuaSnip",
    --version = "2.*",
    --build = "make install_jsregexp",
    dependencies = {
      --"honza/vim-snippets",
      "rafamadriz/friendly-snippets",
    }
  },

  -- Completion framework:
  'hrsh7th/nvim-cmp',
  'saadparwaiz1/cmp_luasnip',
  -- LSP completion source:
  'hrsh7th/cmp-nvim-lsp',

  -- Useful completion sources:
  'hrsh7th/cmp-nvim-lua',
  'hrsh7th/cmp-nvim-lsp-signature-help',
  --'hrsh7th/cmp-vsnip',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-buffer',
  --'hrsh7th/vim-vsnip',

  "ellisonleao/gruvbox.nvim",
  'nvim-telescope/telescope.nvim',
  'edluffy/specs.nvim',
  'nvim-tree/nvim-web-devicons',
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {{
      'nvim-tree/nvim-web-devicons',
      lazy = true
    },
    'arkav/lualine-lsp-progress'}
  },
  'lambdalisue/suda.vim',
  { 'lukas-reineke/indent-blankline.nvim', main = "ibl", opts = {} },
  {'lewis6991/gitsigns.nvim',
    opts = {}
  },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icon
    }
  },
  {
    "SmiteshP/nvim-navic",
    dependencies = "neovim/nvim-lspconfig"
  },
  {
    "cshuaimin/ssr.nvim",
    -- Calling setup is optional.
    opts = {
      min_width = 50,
      min_height = 5,
      keymaps = {
        close = "q",
        next_match = "n",
        prev_match = "N",
        replace_all = "<leader><cr>",
      },
    }
  },
  {'ahmedkhalf/project.nvim',
    config = function()
        require('project_nvim').setup {}
    end
  },
  'lervag/vimtex',
  'ctrlpvim/ctrlp.vim',
  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    'jedrzejboczar/possession.nvim',
    opts = {
            commands = {
                save = 'SSave',
                load = 'SLoad',
                delete = 'SDelete',
                list = 'SList',
            },
            autosave = {
                current = true
            },
            plugins = {
                delete_hidden_buffers = false,
                delete_buffers = true
            }
        },
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  'nvim-telescope/telescope-ui-select.nvim',
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'smoka7/hop.nvim',
    version = "*",
    opts = { keys = 'etovxqpdygfblzhckisuran' }
  },
  -- this is more up to date than the default rust.vim that comes with neovim
  {
    'mrcjkb/rustaceanvim',
    version = '^6', -- Recommended
    ft = { 'rust' },
    lazy = false,
    dependencies = {
      'mfussenegger/nvim-dap'
    }
  },
  { 'rcarriga/nvim-dap-ui', dependencies = {'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio'} },
  { 'theHamsta/nvim-dap-virtual-text' },
  {
    'nvim-orgmode/orgmode',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter', lazy = true },
    },
    event = 'VeryLazy',
    opts = {
        org_agenda_files = '~/orgfiles/**/*',
        org_default_notes_file = '~/orgfiles/refile.org',
      },
    ft = { 'org' },
  },
  { 'nvim-neorg/neorg',
    lazy = true,
    ft = "norg",
    version = "*",
    opts = {
        load = {
            ["core.defaults"] = {},
            ["core.concealer"] = {},
            ["core.integrations.image"] = {},
            ["core.latex.renderer"] = {},
            ["core.export"] = {},
            ["core.qol.toc"] = {},
            ["core.completion"] = {
                config = {
                    engine = "nvim-cmp",
                },
            },
            ["core.integrations.telescope"] = {},
            ["core.integrations.treesitter"] = {
                config = {
                    configure_parsers = true,
                    install_parsers = true,
                }
            },
        }
    },
    dependencies = { { "nvim-lua/plenary.nvim" }, { "nvim-neorg/neorg-telescope" } },
  },
  {"3rd/image.nvim"},
  {"3rd/diagram.nvim",
    dependencies = {
        "3rd/image.nvim",
    },
  },
  {"jubnzv/mdeval.nvim",
    opts = {
        require_confirmation = false,
        eval_options = {
            python = {
                command = {"python"},
                language_code = "python",
                exec_type = "interpreted",
                extension = "py",
            }
        }
    }
  },
  {"FabijanZulj/blame.nvim",
    opts = {},
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim",        -- optional
      "ibhagwan/fzf-lua",              -- optional
    },
    config = true
  },
  'rcarriga/nvim-notify',
  {'numToStr/Navigator.nvim',
    opts = {}
  },
  {
    'goolord/alpha-nvim',
    config = function ()
        local db = require'alpha.themes.startify'
        local config = db.config
        -- add sessions
        local utils = require 'possession.utils'
        local query = require 'possession.query'
        local workspaces = {
            {'Sessions', 'a', {'~/projects'}}
        }
        local get_layout = function()
            return query.alpha_workspace_layout(workspaces, db.button, {})
        end

        local sessions = {
            type = 'group',
            val = utils.throttle(get_layout, 5000)
        }
        table.insert(config.layout, sessions)
        -- helpers
        local helpers = {
            type = 'group',
            val = {
                {type = 'padding', val = 1},
                {type = 'text', val = 'Helpers', opts = {hl = 'Type'}},
                {type = 'padding', val = 1},
                db.button("z", "鈴" .. " Lazy", ":Lazy<CR>"),
            }
        }
        table.insert(config.layout, helpers)

        require'alpha'.setup(config)
    end
  },
  {
    "ray-x/go.nvim",
    dependencies = {  -- optional packages
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
    },
    opts = {},
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
  --'jamestthompson3/nvim-remote-containers',
  'puremourning/vimspector',
  'Vigemus/iron.nvim',
  {"nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter"
    }
  },
  'stevearc/vim-arduino',
  'jpalardy/vim-slime',
  {
  "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
  },
  {
    "oskarrrrrrr/symbols.nvim",
    config = function()
        local r = require("symbols.recipes")
        require("symbols").setup(
            r.DefaultFilters,
            r.AsciiSymbols,
            {
                sidebar = {
                    open_direction = "try-right",
                    show_inline_details = true
                }
            }
        )
        vim.keymap.set("n", ",s", "<cmd>Symbols<CR>")
        vim.keymap.set("n", ",S", "<cmd>SymbolsClose<CR>")
    end
  }
}
}

local opts = {}

require("lazy").setup(plugins, opts)
