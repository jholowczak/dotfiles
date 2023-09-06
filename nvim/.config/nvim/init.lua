require 'plugins'
require 'tmux'
require 'lsp'
require 'keymap'

local opt = vim.opt
local wo = vim.wo

-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()

-- Tree-sitter configuration
require'nvim-treesitter.configs'.setup {
  modules = { "highlight" },
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {'org'}, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
  },
  auto_install = true,
  sync_install = false,
  ignore_install = {},
  ensure_installed = {'org', 'go', 'gomod', 'html', 'latex', 'rust', 'c', 'python',
    'toml', 'lua', 'json', 'jsonnet', 'v', 'yaml', 'r', 'regex', 'sql', 'zig',
    'javascript', 'make', 'hcl', 'haskell', 'diff', 'cpp', 'css',
    'bash', 'fish', 'dockerfile', 'nix', 'gitignore', 'markdown'
    }, -- Or run :TSUpdate org
}
wo.foldmethod = 'expr'
wo.foldexpr = 'nvim_treesitter#foldexpr()'
wo.foldenable = false

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
    opt.shell = "/usr/local/bin/bash"
else
    opt.shell = "/usr/bin/bash"
end
opt.timeoutlen = 2000
opt.shortmess = "at"
opt.ruler = true
opt.number = true
opt.autoindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.autoread = true
opt.expandtab = true
opt.fileformats = "unix,dos,mac"
opt.showmatch = true
opt.splitbelow = true
opt.splitright = true
opt.wildmenu = true
opt.wildmode = "list:longest,full"
opt.mouse = "a"
opt.backspace = "indent,eol,start"
opt.clipboard = "unnamedplus"
opt.background = "dark"
opt.termguicolors = true
opt.background = "dark" -- or "light" for light mode
vim.cmd([[colorscheme gruvbox]])
opt.colorcolumn = "0"




-- airline
-- vim.g.airline.extensions.tabline.enabled = 1
-- vim.g.airline.extensions.tabline.show_buffers = 1
-- vim.g.airline_powerline_fonts = 1
-- vim.g.airline_theme = 'hybrid'
local navic = require('nvim-navic')
local function session_name()
  return require('possession.session').session_name or ''
end
local function navic_location()
	local none_display = " "
	if navic.is_available() then
		local l = navic.get_location()
		return (l ~= "") and l or none_display
	else
		return none_display
	end
end
require('lualine').setup {
  options = {
    theme = 'horizon',
  },
  winbar = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {navic_location},
    lualine_x = {session_name},
    lualine_y = {},
    lualine_z = {}
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename', "lsp_progress"},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  tabline = {
    lualine_a = {{"buffers", mode=2}},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {{"tabs", mode=2}},
  },
  extensions = {'nvim-tree', 'nvim-dap-ui'}
}

-- supertab for lsp tab completion
vim.g.SuperTabDefaultCompletionType = "<c-x><c-o>"


-- rust specific configs
vim.g.rust_recommended_style = 1
vim.g.rustfmt_autosave = 1

