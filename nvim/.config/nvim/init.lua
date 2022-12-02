local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager
  use{'nvim-treesitter/nvim-treesitter', run = ":TSUpdate"}
  use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
  use 'ms-jpq/coq_nvim'
  use 'ms-jpq/coq.artifacts'
  use 'ms-jpq/coq.thirdparty'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use "ellisonleao/gruvbox.nvim"
  use 'kyazdani42/nvim-web-devicons'
  use 'ervandew/supertab'
  use {
    "jiaoshijie/undotree",
    config = function()
      require('undotree').setup()
    end,
    requires = {
      "nvim-lua/plenary.nvim",
    },
  }
  use "lukas-reineke/indent-blankline.nvim"
  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    }
  }
  use {
    "SmiteshP/nvim-navic",
    requires = "neovim/nvim-lspconfig"
  }
  use {
    "cshuaimin/ssr.nvim",
    module = "ssr",
    -- Calling setup is optional.
    config = function()
      require("ssr").setup {
        min_width = 50,
        min_height = 5,
        keymaps = {
          close = "q",
          next_match = "n",
          prev_match = "N",
          replace_all = "<leader><cr>",
        },
      }
    end
  }
  use {
  "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {}
    end
  }
  use 'lervag/vimtex'
  use { 'ctrlpvim/ctrlp.vim' }
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  use {
    'Shatur/neovim-session-manager',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function() require('session_manager').setup {} end
  }
  use {'nvim-telescope/telescope-ui-select.nvim' }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'phaazon/hop.nvim',
    branch = 'v1', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }
  -- this is more up to date than the default rust.vim that comes with neovim
  use 'rust-lang/rust.vim' 
  use { 
    'simrat39/rust-tools.nvim',
    requires = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      'mfussenegger/nvim-dap'
    },
    config = function() require('rust-tools').setup {} end
  }

  use {'nvim-orgmode/orgmode', 
    config = function()
      require('orgmode').setup{
        org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
        org_default_notes_file = '~/Dropbox/org/refile.org',
      }
    end
  }

  use { 
      'TimUntersberger/neogit', 
      requires = 'nvim-lua/plenary.nvim',
      config = function() require('neogit').setup {} end
  }
  use { 'alexghergh/nvim-tmux-navigation', config = function()
        require'nvim-tmux-navigation'.setup {}
    end
  }
  use {
    'goolord/alpha-nvim',
    config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end
  }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()

-- Tree-sitter configuration
require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {'org'}, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
  },
  ensure_installed = {'org', 'go', 'gomod', 'html', 'latex', 'rust', 'c', 'python', 
    'toml', 'lua', 'json', 'jsonnet', 'v', 'yaml', 'r', 'regex', 'sql', 'zig',
    'javascript', 'make', 'jq', 'hcl', 'haskell', 'diff', 'cpp', 'css',
    'bash', 'fish', 'dockerfile', 'nix', 'gitignore', 'gitcommit', 'git_rebase', 'markdown'
    }, -- Or run :TSUpdate org
}

require('indent_blankline').setup {}
require("telescope").setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    }
  }
}
require("telescope").load_extension("ui-select")

-- required for project.nvim to work with nvim-tree
require("nvim-tree").setup({
  respect_buf_cwd = true,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true
  },
  actions = {
    open_file = {
      quit_on_open = true
    }
  }
})

--vim options
if vim.loop.os_uname().sysname == "Darwin" then
    vim.opt.shell = "/usr/local/bin/bash"
else 
    vim.opt.shell = "/usr/bin/bash"
end

vim.opt.timeoutlen = 2000
vim.opt.shortmess = "at"
vim.opt.ruler = true
vim.opt.number = true
vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoread = true
vim.opt.expandtab = true
vim.opt.fileformats = "unix,dos,mac"
vim.opt.showmatch = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wildmenu = true
vim.opt.wildmode = "list:longest,full"
vim.opt.mouse = "a"
vim.opt.backspace = "indent,eol,start"
vim.opt.clipboard = "unnamedplus"
vim.opt.background = "dark"
vim.opt.termguicolors = true
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
vim.opt.colorcolumn = "0"

-- KEYMAPS
vim.mapleader = " "
vim.g.mapleader = " "

local function kmap(mode, lhs, rhs, opts, buf)
  local lhs_e = string.gsub(lhs, '<l>', '<leader>')
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  if buf then
      vim.api.nvim_buf_set_keymap(buf, mode, lhs_e, rhs, options)
  else
      vim.api.nvim_set_keymap(mode, lhs_e, rhs, options)
  end
end

kmap("n", "<l>nm", ":bprevious<cr>")
kmap("n", "<l>nn", ":bnext<cr>")
kmap("n", "<l>nd", ":bdelete<cr>")
kmap("n", "<l>no", ":only<cr>")
kmap("n", "<l>ns", "<C-W><C-W>")
kmap("n", "<l>nb", ":CtrlPBuffer<cr>")
kmap("n", "<l>j", "<C-d>")
kmap("n", "<l>k", "<C-u>")
kmap("n", "<l>=", "<C-w>=")
kmap("n", "<l>-", ":res -5<cr>")
kmap("n", "<l>+", ":res +5<cr>")
kmap("n", "<l>nt", ":NvimTreeOpen<cr>")
kmap("n", "<l>ss", ":setlocal spell spelllang=en_us<cr>")
kmap("n", "<l>sf", ":setlocal nospell<cr>")
kmap("n", "<l>sn", "]s")
kmap("n", "<l>sp", "[s")
kmap("n", "<l>sr", "z=")
kmap("n", "<l>sa", "zg")
kmap("n", "<l>rr", ":lua tmux_send_buf()<cr>")
kmap("n", "<l>vp", ":lua tmux_send_command('')<cr>")
kmap("n", "<l>vl", ":lua tmux_send_last_command()<cr>")
--kmap("n", "<l>mb", ":lua tmux_send_command('git blame -L ' .. vim.fn.line('.') .. ',' .. vim.fn.line('.') .. ' ' .. vim.fn.expand('%:p'))<cr>", opts)
kmap('n', '<l>dd', '<cmd>lua vim.diagnostic.open_float()<cr>')
kmap("n", "<l>co", ":edit ~/.config/nvim/init.lua<CR>")
kmap("n", "<l>cl", ":source ~/.config/nvim/init.lua<cr>")
kmap("n", "<l>ms", "<cmd>lua require('neogit').open({ kind = \"split\" })<cr>")
vim.keymap.set({ "n", "x" }, "<leader>rs", function() require("ssr").open() end)
vim.keymap.set('n', '<leader>u', require('undotree').toggle, { noremap = true, silent = true })



kmap("n", "<l><l>b", "<cmd>HopWordBC<CR>")
kmap("n", "<l><l>w", "<cmd>HopWordAC<CR>")
kmap("n", "<l><l>j", "<cmd>HopLineAC<CR>")
kmap("n", "<l><l>k", "<cmd>HopLineBC<CR>")
kmap("v", "<l><l>w", "<cmd>HopWordAC<CR>")
kmap("v", "<l><l>b", "<cmd>HopWordBC<CR>")
kmap("v", "<l><l>j", "<cmd>HopLineAC<CR>")
kmap("v", "<l><l>k", "<cmd>HopLineBC<CR>")
kmap('n', "<C-h>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLeft()<cr>")
kmap('n', "<C-j>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateDown()<cr>")
kmap('n', "<C-k>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateUp()<cr>")
kmap('n', "<C-l>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateRight()<cr>")
kmap('n', "<C-\\>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateLastActive()<cr>")
--kmap('n', "<C-Space>", ":lua require'nvim-tmux-navigation'.NvimTmuxNavigateNext()<cr>", opts)

-- airline
vim.cmd("let g:airline#extensions#tabline#enabled = 1")
vim.cmd("let g:airline#extensions#tabline#show_buffers=1")
vim.cmd("let g:airline_powerline_fonts=1")
vim.cmd("let g:airline_theme = 'hybrid'")
-- lsp configuration
-- Automatically start coq
local on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  
  kmap('n', '<leader>t', '<cmd>lua vim.lsp.buf.hover()<cr>', nil, bufnr)
  kmap('n', '<leader>gg', '<cmd>lua vim.lsp.buf.definition()<cr>', nil, bufnr)
  kmap('n', '<leader>gp', ':pop<cr>', nil, bufnr)
  kmap('n', '<leader>gl', '<cmd>lua vim.lsp.buf.references()<cr>', nil, bufnr)
  kmap('n', '<leader>gr', '<cmd>lua vim.lsp.buf.rename()<cr>', nil, bufnr)
  kmap('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', nil, bufnr)
  kmap('n', '<leader>gh', '<cmd>lua vim.lsp.buf.signature_help()<cr>', nil, bufnr)
end

vim.g.coq_settings = { auto_start = true }
local servers = { 'rust_analyzer', 'clangd', 'gopls', 'terraformls', 'pylsp', 'zls', 'yamlls',
    'hls', 'jsonls', 'jsonnet_ls', 'marksman', 'html', 'texlab', 'sumneko_lua'
    }
for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup(
      require('coq').lsp_ensure_capabilities({
        on_attach = on_attach,
        flags = {
          -- This will be the default in neovim 0.7+
          debounce_text_changes = 150,
        }
      })
  )
end

-- supertab for lsp tab completion
vim.g.SuperTabDefaultCompletionType = "<c-x><c-o>"


-- rust specific configs
vim.g.rust_recommended_style = 1
vim.g.rustfmt_autosave = 1

-- tmux operations
vim.g.tmux_last_command = ""

function tmux_window_exists()
    output = vim.fn.system("tmux list-panes |grep 1:")
    if output == "" then
        return false
    else
        return true
    end
end

function tmux_toggle() 
    if not tmux_window_exists() then
        vim.g.tmux_session = vim.fn.system("tmux split-window -h")
        vim.fn.system("tmux select-pane -L")
    end
end

function tmux_send_command(txt)
    vim.g.tmux_last_command = txt

    if txt == "" then
        input = vim.fn.input("tmux input: ")
        if input ~= "" then
            tmux_send_command(input)
        end 
    else
        if tmux_window_exists() then
            vim.fn.system("tmux send-keys -t 1 " .. "'" .. txt .. "\n'") 
        else
            tmux_toggle()
            vim.fn.system("tmux send-keys -t 1 " .. "'" .. txt .. "\n'") 
        end
    end
end

function tmux_send_last_command() 
    tmux_send_command(vim.g.tmux_last_command) 
end

local function tmux_send_block() 
    start = vim.fn.line(".")
    _end = vim.fn.search("^$")
    lines = vim.fn.getbufline(vim.fn.bufnr("%"), start, _end-1)
    for k,v in pairs(lines) do
        if v ~= "" then
            tmux_send_command(v)
        end
    end
    vim.fn.execute("normal! :" .. _end)
end

local function tmux_send_function() 
    start = vim.fn.line(".")
    vim.fn.execute("normal! ][")
    _end = vim.fn.line(".")
    lines = vim.fn.getbufline(vim.fn.bufnr("%"), start, _end)
    for k,v in pairs(lines) do
        if v == "" then
            tmux_send_command("\n")
        else 
            tmux_send_command(v)
        end
    end
    vim.fn.execute("normal! :" .. _end)
end

function tmux_send_buf()
    if string.find(vim.fn.getline("."), "function") ~= nil then
        tmux_send_function()
    else
        tmux_send_block()
    end
end





