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
  { "folke/neodev.nvim", opts = {} },
  {'nvim-treesitter/nvim-treesitter'},
  'neovim/nvim-lspconfig', -- Collection of configurations for the built-in LSP client
  {'ms-jpq/coq_nvim', build = ":COQdeps"},
  'ms-jpq/coq.artifacts',
  'ms-jpq/coq.thirdparty',
  "ellisonleao/gruvbox.nvim",
  --{'nvimdev/dashboard-nvim',
  --  event = 'VimEnter',
  --  config = function()
  --      require('dashboard').setup {
  --          theme = 'hyper',
  --          config = {
  --              project = { enable = true, limit = 8, action = 'Telescope projects' }
  --          }
  --      }
  --  end,
  --  dependencies = {{'nvim-tree/nvim-web-devicons'}}
  --},
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
  'lewis6991/gitsigns.nvim',
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
    config = function()
        require('possession').setup {
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
                delete_hidden_buffers = false
            }
        }
    end,
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
  --'rust-lang/rust.vim',
  --disabling for now, no updates in a year
  {
    'simrat39/rust-tools.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      'mfussenegger/nvim-dap'
    },
  },
  {
    'nvim-orgmode/orgmode',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter', lazy = true },
    },
    event = 'VeryLazy',
    config = function()
      -- Load treesitter grammar for org
      require('orgmode').setup_ts_grammar()

      -- Setup orgmode
      require('orgmode').setup({
        org_agenda_files = '~/orgfiles/**/*',
        org_default_notes_file = '~/orgfiles/refile.org',
      })
    end,
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
  'alexghergh/nvim-tmux-navigation',
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
    },
    config = function()
      require("go").setup()
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },
}

local opts = {}

require("lazy").setup(plugins, opts)
