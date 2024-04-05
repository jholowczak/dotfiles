require 'plugins'
require 'tmux'
require 'opts'
require 'treesitter'
require 'lsp'
require 'keymap'
require 'layout'

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

-- rust specific configs
vim.g.rust_recommended_style = 1
vim.g.rustfmt_autosave = 1

