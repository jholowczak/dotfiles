require 'plugins'
require 'tmux'
require 'lsp'
require 'keymap'
require 'layout'

local opt = vim.opt
local cmd = vim.cmd

-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()

-- Tree-sitter configuration
require'nvim-treesitter.configs'.setup { modules = { "highlight" },
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = {'org'}, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
  },
  auto_install = false,
  sync_install = false,
  ignore_install = {},
  ensure_installed = {'org', 'go', 'gomod', 'html', 'latex', 'rust', 'c', 'python',
    'toml', 'lua', 'json', 'jsonnet', 'v', 'yaml', 'r', 'regex', 'sql', 'zig',
    'javascript', 'make', 'hcl', 'haskell', 'diff', 'cpp', 'css',
    'bash', 'fish', 'dockerfile', 'nix', 'gitignore', 'markdown'
    }, -- Or run :TSUpdate org
}
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldenable = false

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
  -- sync_root_with_cwd = true,
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

require("telescope").load_extension("projects")


require("telescope").load_extension("possession")

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
opt.background = "dark" -- or "light" for light mode
cmd([[colorscheme gruvbox]])
opt.colorcolumn = "0"
opt.termguicolors = true

opt.list = true
opt.listchars:append "space:⋅"
opt.listchars:append "eol:↴"

--require("indent_blankline").setup {
--    --show_trailing_blankline_indent = false,
--    --show_current_context_start =false
--}

-- supertab for lsp tab completion
--vim.g.SuperTabDefaultCompletionType = "<c-x><c-o>"

-- rust specific configs
vim.g.rust_recommended_style = 1
vim.g.rustfmt_autosave = 1

