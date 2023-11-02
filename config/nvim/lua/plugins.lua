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
  'glepnir/dashboard-nvim',
  'kyazdani42/nvim-web-devicons',
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {{
      'kyazdani42/nvim-web-devicons',
      lazy = true
    },
    'arkav/lualine-lsp-progress'}
  },
  'ervandew/supertab',
  'lambdalisue/suda.vim',
  { 'lukas-reineke/indent-blankline.nvim', main = "ibl", opts = {} },
  'lewis6991/gitsigns.nvim',
  {
    'kyazdani42/nvim-tree.lua',
    dependencies = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
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
  "ahmedkhalf/project.nvim",
  'lervag/vimtex',
  'ctrlpvim/ctrlp.vim',
  {
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  {
    'jedrzejboczar/possession.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
  },
  'nvim-telescope/telescope-ui-select.nvim',
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'phaazon/hop.nvim',
    branch = 'v1', -- optional but strongly recommended
      -- you can configure Hop the way you like here; see :h hop-config
    opts = { keys = 'etovxqpdygfblzhckisuran' }
  },
  -- this is more up to date than the default rust.vim that comes with neovim
  'rust-lang/rust.vim',
  {
    'simrat39/rust-tools.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      'mfussenegger/nvim-dap'
    },
    config = function()
        local rt = require('rust-tools')
        rt.setup({
          server = {
            on_attach = function(_, bufnr)
              -- Hover actions
              vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
              -- Code action groups
              vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
            end,
          },
        })
    end
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
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end
  }
}

local opts = {}

require("lazy").setup(plugins, opts)
